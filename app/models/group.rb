# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :user

  has_many :group_things, dependent: :destroy
  # TODO: no dependent. Make sure that this is fine with rubocop but that we
  # don't delete `things` just because a stupid ass group has been deleted.
  has_many :things, through: :group_things

  validates :name, uniqueness: { scope: [:user_id] }
end
