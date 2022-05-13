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

    transaction do
      @thing = Thing.new(pars)
      @thing.save!

      @thing = @thing.reload
      @thing.add_people!(authors: pars['authors'], translators: pars['translators'])
    end

    render status: :created
  end

  def show; end

  def update
    pars = thing_params

    transaction do
      @thing.update!(pars.except('languages'))
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
    # TODO: watch out for array parameters!
    params.permit(
      :target, :title, :publisher, :address, :year, :url, :access, :location,
      :insideof, :pages, :note, :rate, :status, :kind, :bought_at,
      :tags, :annotations,
      authors: [], translators: [], languages: []
    ).tap do |obj|
      obj['languages'] = Language.by_code!(obj['languages'])
      obj['user_id'] = @current_user.id
    end
  end
end
