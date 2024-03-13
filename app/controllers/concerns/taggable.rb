# frozen_string_literal: true

# This module provides methods for controllers that have to deal with tag
# references (i.e. comments and things). This is closely tied to `TagReference`
# and its polymorphic `:taggable` column.
module Taggable
  extend ActiveSupport::Concern

  # Update tag references for the given `object` with tags identified by the
  # `ids` array.
  def update_tags!(object:, ids:)
    object.tag_references.destroy_all
    return true unless ids

    ids.each { |id| TagReference.create!(tag_id: id, taggable: object) }
  end
end
