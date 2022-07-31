# frozen_string_literal: true

require 'net/http'

# HttpHandler is a class that wraps all the HTTP methods so there is less boilerplate along the way.
class HttpHandler
  attr_accessor :token

  def initialize(url:)
    @base = url
  end

  def do!(method:, path:, data: nil, expected:)
    uri = URI.join(@base, path)
    req = build_request(method:, uri:)
    req.body = data.to_json unless data.blank?

    res = Net::HTTP.start(uri.hostname, uri.port, options(uri)) { |http| http.request(req) }
    if unexpected?(expected:, code: res.code.to_i)
      ap JSON.parse(res.body) unless res.body.blank?
      raise StandardError, "Expecting code #{expected}, got #{res.code} instead!"
    end

    res.body.present? ? JSON.parse(res.body) : ''
  end

  def create_and_login!(username:, password:)
    resp = do!(method: 'get', path: '/users/can', expected: 200)
    create!(username:, password:) if resp['can']

    login!(username:, password:)
  end

  protected

  def create!(username:, password:)
    data = { username:, password: }
    do!(method: 'post', path: '/users', data:, expected: 201)
  end

  def login!(username:, password:)
    data = { username:, password: }
    resp = do!(method: 'post', path: '/auth/login', data:, expected: 200)

    @token = resp['token']
    raise StandardError, 'Empty token!' if @token.blank?
  end

  def unexpected?(expected:, code:)
    return !expected.include?(code) if expected.respond_to?(:include?)

    expected != code
  end

  def build_request(method:, uri:)
    req = Net::HTTP.const_get(method.capitalize).new(uri)
    req["Accept"] = "application/json"
    req["Content-Type"] = "application/json"
    req["Authorization"] = @token if @token

    req
  end

  def options(uri)
    { use_ssl: uri.scheme == "https", open_timeout: 10, read_timeout: 10 }
  end
end

##
# Make some preliminary checks before moving on.

# Fetch URL where our server is running.
url = ENV.fetch('OPERUM_URL', '')
if url.blank?
  raise StandardError, 'You have to pass an extra argument: `bundle exec rake db:seed <url>` or provide a value for the `OPERUM_URL` environment variable!' if url.blank?
end

# User that is performing the action.
username, password = ENV.fetch('OPERUM_USERNAME'), ENV.fetch('OPERUM_PASSWORD')
raise StandardError, 'You need to set the `OPERUM_USERNAME` and the `OPERUM_PASSWORD` environment variables' if username.blank? || password.blank?

# Load the YAML file.
path = ENV.fetch('OPERUM_SEED_FILE', Rails.root.join('db/seeds/default.yml'))
things = YAML.load_file(path)

##
# Make sure that the user knows what he/she is doing.

if ENV['CI'].blank?
  print 'This will clear whatever it was in your database before, are you sure? [Y/n] '
  resp = $stdin.gets.chomp
  unless resp == '' || resp.downcase == 'y'
    Rails.logger.info 'bye!'
    exit 0
  end
end

##
# Nuke whatever there was before.

# Login. This will save the token to be used in subsequent requests.
handler = HttpHandler.new(url:)
handler.create_and_login!(username:, password:)

# Get everything so to delete it.
# TODO: languages
%w[things people].each do |resource|
  res = handler.do!(method: 'get', path: "/#{resource}", expected: 200)
  res[resource].each do |r|
    handler.do!(method: 'delete', path: "/#{resource}/#{r['id']}", expected: 204)
  end
end

##
# Let's go!

things.each do |t|
  handler.do!(method: 'post', path: '/things', data: t, expected: 201)
end

Rails.logger.info 'done!'
