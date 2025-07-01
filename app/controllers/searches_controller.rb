# frozen_string_literal: true

class SearchesController < ApplicationController
  before_action :set_search, only: %i[show edit update destroy]

  def index
    current_user.update!(last_search_id: nil)
    @search = Search.new
  end

  def show
    current_user.update!(last_search_id: @search.id)
  end

  def new
    @search = Search.new
  end

  def edit; end

  def create
    @search = Search.new(search_params)
    @search.user_id = @current_user.id

    if @search.save
      redirect_to @search
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @search.update(search_params)
      redirect_to @search, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @search.destroy!
    redirect_to searches_url, status: :see_other
  end

  def search
    @search = Search.new
    @search.body = params.permit(:body).fetch(:body, '')
    render 'search', partial: true, locals: { items: @search.results }
  end

  protected

  def set_search
    @search = Search.find(params[:id])
  end

  def search_params
    params.require(:search).permit(:name, :body, :description, :shared)
  end
end
