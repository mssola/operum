# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'presence: username' do
    user = User.new
    user.password = '1234'
    user.password_confirmation = '12345'

    assert_raise(ActiveRecord::RecordInvalid) { user.save! }
  end

  test 'presence: password' do
    user = User.new
    user.username = 'whatever'

    assert_raise(ActiveRecord::RecordInvalid) { user.save! }
  end

  test 'username has to be unique' do
    user = User.new(username: users(:user).username,
                    password: '1234', password_confirmation: '1234')
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }
  end
end
