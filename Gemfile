# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.4.4'

# Rails itself :)
gem 'rails', '~> 8'
gem 'rails-i18n', '~> 8'

# The original asset pipeline for Rails.
gem 'sprockets-rails'

# sqlite3 should be fine for this project, and we keep things simpler.
gem 'sqlite3'

# Web server.
gem 'puma'

# Use JavaScript with ESM import maps.
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator.
gem 'turbo-rails'

# Hotwire's modest JavaScript framework.
gem 'stimulus-rails'

# Use Active Model has_secure_password.
gem 'bcrypt'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants.
gem 'image_processing'

# No longer in the standard library from Ruby 3.4 onwards.
gem 'csv'

# Needed until Ruby 3.3.4 is released https://github.com/ruby/ruby/pull/11006
gem 'net-pop', github: 'ruby/net-pop'

group :development, :test do
  gem 'debug', platforms: %i[mri windows]

  # Convenient & prettier printer.
  gem 'awesome_print'

  # Security
  gem 'brakeman', require: false
  gem 'bundle-audit', require: false
end

group :development do
  # Use console on exceptions pages.
  gem 'web-console'

  # Style
  gem 'rubocop', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  # System testing.
  gem 'capybara'
  gem 'selenium-webdriver'
end
