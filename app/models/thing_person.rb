# frozen_string_literal: true

class ThingPerson < ApplicationRecord
  belongs_to :thing
  belongs_to :person

  enum :role, %i[unknown author translator]
end
