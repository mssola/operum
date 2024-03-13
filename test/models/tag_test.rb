# frozen_string_literal: true

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test 'name is present and unique' do
    tag = Tag.new
    assert_raise(ActiveRecord::RecordInvalid) { tag.save! }

    tag = Tag.new(name: tags(:tag1).name)
    assert_raise(ActiveRecord::RecordInvalid) { tag.save! }

    tag.name = 'another'
    assert_difference('Tag.count') { tag.save! }
  end
end
