# frozen_string_literal: true

require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  test 'name and body have to be present and unique' do
    search = Search.new(user_id: users(:user).id)
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }

    search.name = 'new search'
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }

    search.name = nil
    search.body = 'body'
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }

    search.name = searches(:search1).name
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }

    search.name = 'another'
    search.body = searches(:search1).body
    assert_raise(ActiveRecord::RecordInvalid) { search.save! }

    search.body = 'another body'
    assert_difference('Search.count') { search.save! }
  end

  ##
  # Results.

  test 'returns all things when an empty body is given' do
    res = Search.new.results

    assert res[:things].size == 2
    assert res[:things][0][:target] == things(:thing2).target
    assert res[:things][1][:target] == things(:thing1).target
  end

  test 'returns everything matching a specific tag' do
    res = Search.new(body: "tag:'#{tags(:tag1).name}'").results

    assert res[:things].size == 2
    assert res[:things][0][:target] == things(:thing2).target
    assert res[:things][1][:target] == things(:thing1).target
    assert res[:comments].size == 1
    assert res[:comments][0][:id] == comments(:comment1).id
  end

  test 'returns everything matching two tags' do
    res = Search.new(body: "tag:'#{tags(:tag1).name}' tag:'#{tags(:tag2).name}'").results

    assert res[:things].size == 1
    assert res[:things][0][:target] == things(:thing1).target
    assert res[:comments].empty?
  end

  test 'returns everything matching a given text' do
    res = Search.new(body: 'Miquel').results

    assert res[:things].size == 2
    assert res[:things][0][:target] == things(:thing2).target
    assert res[:things][1][:target] == things(:thing1).target
    assert res[:comments].size == 1
    assert res[:comments][0][:id] == comments(:comment1).id
  end

  test 'returns everything matching two tags and a given text' do
    res = Search.new(body: "Miquel tag:'#{tags(:tag1).name}' tag:'#{tags(:tag2).name}'").results

    assert res[:things].size == 1
    assert res[:things][0][:target] == things(:thing1).target
    assert res[:comments].empty?
  end

  test 'returns everything matching a given compound text' do
    res = Search.new(body: 'some other').results

    assert res[:things].size == 2
    assert res[:things][0][:target] == things(:thing2).target
    assert res[:things][1][:target] == things(:thing1).target
    assert res[:comments].empty?
  end

  test 'returns an empty result with unknown fields' do
    res = Search.new(body: 'whatever:"unknown"').results

    assert res[:things].empty?
    assert res[:comments].empty?
  end
end
