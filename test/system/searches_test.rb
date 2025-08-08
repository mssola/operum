# frozen_string_literal: true

require 'application_system_test_case'

class SearchesTest < ApplicationSystemTestCase
  setup do
    # All actions will require the user to be logged in.
    sign_in!
  end

  test 'root url is searches#index, which contains all things plus the tabs we expect' do
    visit root_url

    # All searches are listed.
    assert_text I18n.t('searches.home')
    searches.each { |s| assert_text s.name }

    # All things are listed
    things.each { |t| assert_text t.title }
  end

  test 'the hidden menu should allow us to go into the searches#new url' do
    find('#toggle-hidden-global-menu').click

    find('#new-search').click

    assert find('#search_body')
    assert_equal page.current_path, new_search_path
  end

  test 'can perform a new search' do
    visit new_search_url

    # Fill in the body input and press enter, otherwise the javascript
    # controller won't fire up.
    fill_in 'search_body', with: 'Miquel'
    find('#search_body').native.send_keys(:return)

    # It's actually a pretty generous search: it should give us all thing and a
    # comment.
    assert_text I18n.t('searches.save')
    assert_text things(:thing1).title
    assert_text things(:thing2).title
    assert_text I18n.t('comments.title')
    assert_text tags(:tag1).name
  end

  test 'can save a new search' do
    visit new_search_url

    # Fill in the body input and press enter, otherwise the javascript
    # controller won't fire up.
    fill_in 'search_body', with: 'Autor'
    find('#search_body').native.send_keys(:return)

    # Hit the save button so the hidden form appears.
    assert_text I18n.t('searches.save')
    find('#save-search').click

    assert_text I18n.t('searches.public')

    fill_in 'Name', with: 'Nova cerca'
    click_on I18n.t('helpers.submit.create')

    assert_text 'Nova cerca'
    assert_equal page.current_path, search_path(Search.find_by(name: 'Nova cerca'))
  end

  test 'can edit a search that is not the Home' do
    # Home cannot be edited.
    find('#toggle-hidden-global-menu').click

    assert_selector 'a', text: I18n.t('general.edit'), count: 0

    # Select search1
    click_on searches(:search1).name

    assert_selector 'a', text: things(:thing1).title, count: 2
    find('#toggle-hidden-global-menu').click

    # It can be edited!
    assert_text I18n.t('general.edit')
    click_on I18n.t('general.edit')

    # If you click on it, you will be on the edit page for it.
    assert find('#search_body')
    assert_equal page.current_path, edit_search_path(searches(:search1))
  end

  test 'edit an existing search works' do
    visit edit_search_url(searches(:search1))

    find('#search_body').native.send_keys(:return)

    # Hit the save button so the hidden form appears.
    assert_text I18n.t('searches.save')
    find('#save-search').click

    assert_text I18n.t('searches.public')

    # Update the name.
    fill_in 'Name', with: 'Nova cerca'
    click_on I18n.t('helpers.submit.update')

    # We have been redirected to search#show, and the name has been refreshed.
    assert_selector 'a', text: searches(:search1).name, count: 0
    assert_text 'Nova cerca'
    assert_equal page.current_path, search_path(searches(:search1))
  end

  test 'can delete a search that is not the Home' do
    # Home cannot be deleted.
    find('#toggle-hidden-global-menu').click

    assert_selector 'a', text: I18n.t('general.delete'), count: 0

    # Select search1
    click_on searches(:search1).name

    assert_selector 'a', text: things(:thing1).title, count: 2
    find('#toggle-hidden-global-menu').click

    # It can be deleted!
    assert_text I18n.t('general.delete')
    accept_alert { click_on I18n.t('general.delete') }

    assert_selector 'a', text: searches(:search1).name, count: 0
    assert_equal searches.size - 1, Search.count
  end
end
