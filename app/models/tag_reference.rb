# frozen_string_literal: true

class TagReference < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end
