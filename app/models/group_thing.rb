# frozen_string_literal: true

class GroupThing < ApplicationRecord
  belongs_to :group
  belongs_to :thing

  validates :thing_id, uniqueness: { scope: [:group_id] }
end
