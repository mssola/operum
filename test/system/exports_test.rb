# frozen_string_literal: true

require 'application_system_test_case'

class ExportsTest < ApplicationSystemTestCase
  setup do
    sign_in!
  end

  test 'can access exports from the hidden menu' do
    find('#toggle-hidden-global-menu').click
    assert_text I18n.t('searches.export.action')

    click_on I18n.t('searches.export.action')
    assert_text I18n.t('searches.export.note-msg')
    assert page.current_path == new_search_exports_path(0)
  end

  test 'can export using multiple formats' do
    visit new_search_exports_path(0)

    assert find('#export-format-button')[:href].ends_with?('/searches/0/exports.csv')

    find('#export-select-format').select('UOC')
    assert find('#export-format-button')[:href].ends_with?('/searches/0/exports.uoc')
  end
end
