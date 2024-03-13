# frozen_string_literal: true

class LicensesController < ApplicationController
  skip_before_action :user_authenticated!, only: %i[show]

  def show; end
end
