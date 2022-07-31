# frozen_string_literal: true

# TODO: tags
# TODO: annotations

class ThingsController < ApplicationController
  before_action :set_thing, only: %i[show update destroy]

  def index
    @things = @current_user.things
  end

  def create
    pars = thing_params

    ActiveRecord::Base.transaction do
      @thing = Thing.new(pars.except('authors', 'translators', 'languages'))
      @thing.save!

      @thing = @thing.reload
      @thing.add_people!(authors: pars['authors'], translators: pars['translators'])
    end

    render status: :created
  end

  def show; end

  def update
    pars = thing_params

    ActiveRecord::Base.transaction do
      @thing.update!(pars.except('authors', 'translators', 'languages'))
      @thing.languages = pars['languages']
      @thing.update_people!(authors: pars['authors'], translators: pars['translators'])
    end

    head :no_content
  end

  def destroy
    @thing.destroy!
  end

  protected

  def set_thing
    @thing = @current_user.things.find(params[:id])
  end

  def thing_params
    params
      .permit(:target, :title, :publisher, :address, :year, :url, :access, :location,
              :insideof, :pages, :note, :rate, :status, :kind, :bought_at,
              :tags, :annotations, authors: [], translators: []
             ).tap do |obj|
      obj['translators'] = [] if obj['translators'].blank?
      obj['languages'] = Language.by_code!(obj['languages'])
      obj['user_id'] = @current_user.id

      obj.require([:target, :title, :authors])
    end
  end
end
