# frozen_string_literal: true

class SharedSearchesController < ApplicationController
  skip_before_action :user_authenticated!, only: %i[show]

  def index
    @searches = Search.where(shared: true)
  end

  def show
    @search = Search.find(params[:search_id])
  end
end
