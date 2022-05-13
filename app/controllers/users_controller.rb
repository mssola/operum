# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  # TODO: disable this endpoint entirely if the admin of the site decides not to
  # allow user creation.
  def create
    @user = User.new(user_params)

    if @user.save
      head :created
    else
      render json:   { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  protected

  def user_params
    params.permit(:username, :password)
  end
end
