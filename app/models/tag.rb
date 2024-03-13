# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :tag_references, dependent: :destroy
end
