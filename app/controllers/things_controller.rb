# frozen_string_literal: true

class ThingsController < ApplicationController
  include Taggable

  before_action :set_thing, only: %i[edit show update destroy]

  def show; end

  def new
    @thing = Thing.new
  end

  def edit; end

  def create
    ps = thing_params
    tag_ids = ps.delete(:tag_ids)
    @thing = Thing.new(ps)
    @thing.user_id = @current_user.id

    updated = ActiveRecord::Base.transaction do
      next unless @thing.save

      update_tags!(object: @thing, ids: tag_ids)
    end

    if updated
      redirect_to thing_url(@thing.reload), notice: t('things.create-success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    ps = thing_params
    tag_ids = ps.delete(:tag_ids)

    updated = ActiveRecord::Base.transaction do
      next unless @thing.update(ps)

      update_tags!(object: @thing, ids: tag_ids)
    end

    if updated
      redirect_to edit_thing_url(@thing), notice: t('things.update-success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @thing.destroy!

    redirect_to root_url, notice: t('things.destroy-success')
  end

  private

  def set_thing
    @thing = Thing.find(params[:id])
  end

  def thing_params
    params.require(:thing).permit(:target, :title, :publisher, :address, :year, :url, :access,
                                  :authors, :insideof, :pages, :rate, :status, :kind, :bought_at,
                                  :editors, :note, :where_is_it, tag_ids: [])
  end
end
