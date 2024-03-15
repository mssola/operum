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
    @searches = Search.order(:name)
  end

  # Redirect to the search that was last used by the current user.
  def redirect_to_search!
    search_id = current_user&.last_search_id

    if search_id
      redirect_to search_path(search_id)
    else
      redirect_to root_url
    end
  end
end
