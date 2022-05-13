# frozen_string_literal: true

class GroupThingsController < ApplicationController
  before_action :set_group

  def index
    @things = @group.things

    render 'things/index', things: @things
  end

  # TODO: bulk create
  def create
    GroupThing.create!(group_thing_params.merge(group_id: @group.id))

    head :created
  end

  # TODO: bulk destroy
  def destroy
    GroupThing.find_by!(group_id: @group.id, thing_id: params[:id]).destroy!
  end

  protected

  def group_thing_params
    params.permit(:thing_id)
  end

  def set_group
    @group = @current_user.groups.find(params[:group_id])
  end
end
