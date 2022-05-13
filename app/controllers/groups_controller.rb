# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: %i[show update destroy]

  def index
    @groups = @current_user.groups
  end

  def create
    @group = Group.create!(group_params.merge(user_id: @current_user.id))

    render status: :created
  end

  def show; end

  def update
    @group.update(group_params)

    head :no_content
  end

  def destroy
    @group.destroy!
  end

  protected

  def set_thing
    @group = @current_user.groups.find(params[:id])
  end

  def group_params
    params.permit(:name)
  end
end
