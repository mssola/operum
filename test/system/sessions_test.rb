# frozen_string_literal: true

require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  test 'logs in successfully' do
    sign_in!
  end

  test 'fails to log in with wrong password' do
    visit new_sessions_url

    fill_in I18n.t('activerecord.attributes.user.username'), with: users(:user).username
    fill_in I18n.t('activerecord.attributes.user.password'), with: 'I AM ERROR'
    click_on I18n.t('sessions.sign-in')

    assert_text I18n.t('sessions.wrong-credentials')
  end

  test 'logs out successfully' do
    sign_in!

    click_on I18n.t('sessions.sign-out')

    assert_text I18n.t('sessions.title')
  end
end
