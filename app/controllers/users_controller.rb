# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create can]
  before_action :ensure_can_create!, only: [:create]

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

  def can
    render json: { can: can_create? }, status: :ok
  end

  protected

  def ensure_can_create!
    return if can_create?

    render json: { errors: 'you are not allowed to create users' }, status: :forbidden
  end

  def can_create?
    opt = APP_CONFIG['users']['create']

    if opt == 'first'
      User.none?
    else
      opt == 'always'
    end
  end

  def user_params
    params.permit(:username, :password)
  end
end
