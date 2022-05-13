# frozen_string_literal: true

module JwtAuth
  extend ActiveSupport::Concern

  def jwt_encode(payload, exp)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def jwt_decode(token)
    JWT.decode(token, Rails.application.secret_key_base).first
  end
end
