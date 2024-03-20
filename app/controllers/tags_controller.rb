# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag, only: %i[edit update destroy]

  def index
    @tags = Tag.order(:name)
  end

  def new
    @tag = Tag.new
  end

  def edit; end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to tags_url, notice: t('tags.create-success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_url, notice: t('tags.update-success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy!

    redirect_to tags_url, notice: t('tags.destroy-success')
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
