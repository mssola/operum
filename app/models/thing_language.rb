# frozen_string_literal: true

class ThingLanguage < ApplicationRecord
  belongs_to :thing
  belongs_to :language
end
