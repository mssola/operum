# frozen_string_literal: true

# SessionsController holds the logic for logging in and out users.
class SessionsController < ApplicationController
  skip_before_action :user_authenticated!, only: %i[new create]
  skip_before_action :set_searches, only: %i[new create]

  # We only need to render its template.
  def new; end

  # Create a session for the current user.
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to_search!
    else
      redirect_to root_url, alert: t('sessions.wrong-credentials')
    end
  end

  # Destroy the current session in order to log out.
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
