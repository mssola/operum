# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JwtAuth
  include ErrorResponse

  before_action :authenticate_request
  before_action :set_locale

  rescue_from Exception, with: :error_response

  protected

  # Set the current user based on the 'Authorization' request header.
  def authenticate_request
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded = jwt_decode(header)

    @current_user = User.find(decoded['user_id'])
  end

  # Set the locale for the final response.
  def set_locale
    header = request.headers['Accept-Language']
    header = 'en' if header.blank?

    code = header.split(',').first.strip.to_sym

    I18n.locale = if I18n.available_locales.include?(code)
                    code
                  else
                    I18n.default_locale
                  end

    response.headers['Content-Language'] = I18n.default_locale
  end
end
