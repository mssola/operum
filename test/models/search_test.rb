# frozen_string_literal: true

require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  test 'name and body have to be present' do
    search = Search.new(user_id: users(:user).id)
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }

    search.name = 'new search'
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }

    search.name = nil
    search.body = 'body'
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }
  end

  test 'name and body have to be unique' do
    search = Search.new(user_id: users(:user).id)

    search.name = searches(:search1).name
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }

    search.name = 'another'
    search.body = searches(:search1).body
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }
  end

  ##
  # Results.

  test 'returns all things when an empty body is given' do
    res = Search.new.results

    assert_equal 2, res[:things].size
    assert_equal res[:things][0][:target], things(:thing2).target
    assert_equal res[:things][1][:target], things(:thing1).target
  end

  test 'returns everything matching a specific tag' do
    res = Search.new(body: "tag:'#{tags(:tag1).name}'").results

    assert_equal res[:things].map(&:target), [things(:thing2).target, things(:thing1).target]
    assert_equal res[:comments].map(&:id), [comments(:comment1).id]
  end

  test 'returns everything matching two tags' do
    res = Search.new(body: "tag:'#{tags(:tag1).name}' tag:'#{tags(:tag2).name}'").results

    assert_equal 1, res[:things].size
    assert_equal res[:things][0][:target], things(:thing1).target
    assert_empty res[:comments]
  end

  test 'returns everything matching a given text' do
    res = Search.new(body: 'Miquel').results

    assert_equal res[:things].map(&:target), [things(:thing2).target, things(:thing1).target]
    assert_equal res[:comments].map(&:id), [comments(:comment1).id]
  end

  test 'returns everything matching two tags and a given text' do
    res = Search.new(body: "Miquel tag:'#{tags(:tag1).name}' tag:'#{tags(:tag2).name}'").results

    assert_equal 1, res[:things].size
    assert_equal res[:things][0][:target], things(:thing1).target
    assert_empty res[:comments]
  end

  test 'returns everything matching a given compound text' do
    res = Search.new(body: 'some other').results

    assert_equal res[:things].map(&:target), [things(:thing2).target, things(:thing1).target]
    assert_empty res[:comments]
  end

  test 'returns an empty result with unknown fields' do
    res = Search.new(body: 'whatever:"unknown"').results

    assert_empty res[:things]
    assert_empty res[:comments]
  end
end
