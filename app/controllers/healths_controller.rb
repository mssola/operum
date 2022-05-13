# frozen_string_literal: true

class HealthsController < ActionController::API
  def index
    head :ok
  end
end
