# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :user_authenticated!
  before_action :set_searches

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_authenticated!
    return if current_user

    redirect_to new_sessions_path
  end

  def set_searches
    @searches = Search.all
  end
end
