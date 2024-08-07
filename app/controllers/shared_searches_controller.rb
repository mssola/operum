# frozen_string_literal: true

class SharedSearchesController < ApplicationController
  skip_before_action :user_authenticated!, only: %i[show]

  def index
    @searches = Search.where(shared: true).order(:name)
  end

  def show
    @search = Search.where(shared: true).find(params[:search_id])
  end
end
