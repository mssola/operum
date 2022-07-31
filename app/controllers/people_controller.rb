# frozen_string_literal: true

class PeopleController < ApplicationController
  before_action :set_person, only: %i[show update destroy]

  def index
    @people = Person.all
  end

  # TODO
  def create; end

  # TODO
  def show; end

  # TODO
  def update; end

  def destroy
    @person.destroy!
  end

  protected

  def set_person
    @person = Person.find(params[:id])
  end
end
