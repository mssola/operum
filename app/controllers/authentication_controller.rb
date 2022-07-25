# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      token = jwt_encode({ user_id: @user.id }, 1.month.from_now)
      render json: { token: }, status: :ok
    else
      head :unauthorized
    end
  end
end
