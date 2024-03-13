# frozen_string_literal: true

require 'test_helper'

class ThingTest < ActiveSupport::TestCase
  test 'validates presence' do
    assert_raise(ActiveRecord::RecordInvalid) { Thing.new.save! }

    # Missing 'title'
    assert_raise(ActiveRecord::RecordInvalid) do
      Thing.new(target: 'target', authors: 'Author',
                user_id: users(:user).id, rate: 5,
                status: Thing.statuses[:read], kind: Thing.kinds[:novel]).save!
    end

    # Missing 'target'
    assert_raise(ActiveRecord::RecordInvalid) do
      Thing.new(title: 'title', authors: 'Author',
                user_id: users(:user).id, rate: 5,
                status: Thing.statuses[:read], kind: Thing.kinds[:novel]).save!
    end

    # Missing 'authors'
    assert_raise(ActiveRecord::RecordInvalid) do
      Thing.new(title: 'title', target: 'target',
                user_id: users(:user).id, rate: 5,
                status: Thing.statuses[:read], kind: Thing.kinds[:novel]).save!
    end

    # Valid!
    assert_difference('Thing.count') do
      Thing.new(title: 'title', target: 'target', authors: 'Author',
                user_id: users(:user).id, rate: 5,
                status: Thing.statuses[:read], kind: Thing.kinds[:novel]).save!
    end
  end

  test "'rate' has to be between 0 and 10" do
    thing = things(:thing1)

    thing.rate = -1
    assert_raise(ActiveRecord::RecordInvalid) { thing.save! }

    thing.rate = 11
    assert_raise(ActiveRecord::RecordInvalid) { thing.save! }

    thing.rate = 5
    thing.save!
  end

  test "'status' has to have a value as defined by its enum" do
    thing = things(:thing1)

    thing.status = 'whatever'
    assert_raise(ActiveRecord::RecordInvalid) { thing.save! }

    thing.status = Thing.statuses[:tobepublished]
    thing.save!
  end

  test "'kind' has to have a value as defined by its enum" do
    thing = things(:thing1)

    thing.kind = 'whatever'
    assert_raise(ActiveRecord::RecordInvalid) { thing.save! }

    thing.kind = Thing.kinds[:other]
    thing.save!
  end

  test 'title and target must be unique' do
    thing = things(:thing1).dup

    thing.title = 'another'
    assert_raise(ActiveRecord::RecordInvalid) { thing.save! }

    thing.target = 'also another'
    thing.title = things(:thing1).title
    assert_raise(ActiveRecord::RecordInvalid) { thing.save! }

    thing.target = 'also another'
    thing.title = 'now for real'
    assert_difference('Thing.count') { thing.save! }
  end

  test 'has many comments' do
    thing = things(:thing1)
    assert thing.comments.size == 1
  end

  test 'has many tags through tag_references' do
    thing = things(:thing1)
    assert thing.tags.size == 2
  end
end
