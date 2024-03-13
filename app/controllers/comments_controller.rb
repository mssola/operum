# frozen_string_literal: true

class CommentsController < ApplicationController
  include Taggable

  before_action :set_thing
  before_action :set_comment, only: %i[update destroy]

  def create
    ps = comment_params
    from = ps.delete(:from)
    tag_ids = ps.delete(:tag_ids)

    ok = ActiveRecord::Base.transaction do
      comment = @thing.comments.create(ps)
      next unless comment

      update_tags!(object: comment, ids: tag_ids)
    end

    flash[:alert] = t('comments.bad-create') unless ok
    handle_from_param!(from:)
  end

  def update
    ps = comment_params
    from = ps.delete(:from)
    tag_ids = ps.delete(:tag_ids)

    ok = ActiveRecord::Base.transaction do
      next unless @comment.update(ps)

      update_tags!(object: @comment, ids: tag_ids)
    end

    flash[:alert] = t('comments.bad-update') unless ok
    handle_from_param!(from:)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy

    handle_from_param!(from: params[:from])
  end

  protected

  def comment_params
    params.required(:comment).permit(:content, :from, tag_ids: [])
  end

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def handle_from_param!(from:)
    if from == 'things/edit'
      redirect_to edit_thing_path(@thing)
    else
      redirect_to @thing
    end
  end
end
