# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'content is present' do
    comment = Comment.new(thing_id: things(:thing1).id)
    assert_raise(ActiveRecord::RecordInvalid) { comment.save! }

    comment.content = 'whatever'
    assert_difference('Comment.count') { comment.save! }
  end

  test 'has many tags through tag_references' do
    comment = comments(:comment1)

    assert_equal 1, comment.tags.size
  end
end
