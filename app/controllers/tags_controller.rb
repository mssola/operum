# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag, only: %i[edit update destroy search]

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
    updated = false

    # An update on the tag name can also mean that we need to modify existing
    # saved searches so we don't break them. Thus, everything needs to pass if
    # we want this action to succeed. For searches it's fine to `#update!` with
    # a bang and let the `rescue` below throw a generic error message. For
    # `@tag` itself we can go the usual Rails-way, but since we don't want
    # errors to be mixed together, we call `#update` without a bang and save the
    # result on a boolean variable.
    ActiveRecord::Base.transaction do
      Search.where('body LIKE ?', "tag:\"#{@tag.name}\"").find_each do |s|
        body = s.body.gsub("tag:\"#{@tag.name}\"", "tag:\"#{tag_params['name']}\"")
        s.update!(body:)
      end

      updated = @tag.update(tag_params)
    end

    if updated
      redirect_to tags_url, notice: t('tags.update-success')
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid
    redirect_to edit_tag_path(@tag), alert: t('tags.update-fail')
  end

  def destroy
    @tag.destroy!

    redirect_to tags_url, notice: t('tags.destroy-success')
  end

  def search
    @search = Search.new(name: 'temporary', body: "tag:\"#{@tag.name}\"")

    render 'searches/show'
  end

  private

  def set_tag
    @tag = Tag.find(params[:id] || params[:tag_id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
