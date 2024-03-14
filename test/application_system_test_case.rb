# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  # Sign in with the default user.
  def sign_in!
    visit new_sessions_url

    fill_in I18n.t('activerecord.attributes.user.username'), with: users(:user).username
    fill_in I18n.t('activerecord.attributes.user.password'), with: '12341234'
    click_on I18n.t('sessions.sign-in')

    assert_text I18n.t('searches.home')
  end

  # Sign out the current user if it's already signed in, otherwise do nothing.
  def sign_out_maybe!
    click_on I18n.t('sessions.sign-out')

    assert_text I18n.t('sessions.title')
  rescue Capybara::ElementNotFound
    # We were not logged in, do nothing.
  end
end
