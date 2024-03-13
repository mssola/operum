# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'has to provide username and password' do
    user = User.new
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }

    user.username = 'whatever'
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }

    user.password = '1234'
    user.password_confirmation = '12345'
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }

    user.password_confirmation = '1234'
    assert_difference('User.count') do
      user.save!
    end
  end

  test 'username has to be unique' do
    user = User.new(username: users(:user).username,
                    password: '1234', password_confirmation: '1234')
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }
  end
end
