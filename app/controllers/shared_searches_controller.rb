# frozen_string_literal: true

class SharedSearchesController < ApplicationController
  skip_before_action :user_authenticated!, only: %i[show]

  def index
    @searches = Search.order(:name)
    @saved_searches = @searches.where(shared: true)
    @subtitle = I18n.t('searches.shared.title')
  end

  def show
    @search = Search.where(shared: true).find(params[:search_id])
    @subtitle = @search.name
    @results = @search.results.values.flatten
  end
end
