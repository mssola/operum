# frozen_string_literal: true

require 'application_system_test_case'

class SharedSearchesTest < ApplicationSystemTestCase
  test 'can access shared_searches#index from the hidden menu' do
    sign_in!

    find('#toggle-hidden-global-menu').click
    assert_text I18n.t('searches.shared.title').downcase

    click_on I18n.t('searches.shared.title').downcase
    assert_text I18n.t('searches.shared.none')
  end

  test 'cannot access shared_searches#index if not logged in' do
    sign_out_maybe!

    visit shared_searches_path
    assert_text I18n.t('sessions.title')
    assert page.current_path == new_sessions_path
  end

  test 'shared_searches#show gives us the expected results' do
    # NOTE: not logged in!

    searches(:search1).update!(shared: true)

    visit search_shared_path(searches(:search1))
    assert_text things(:thing1).title
    assert_text things(:thing2).title
    assert_text I18n.t('comments.title')
  end
end
