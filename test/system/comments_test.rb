# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup { sign_in! }

  ##
  # In things#show

  test 'things#show: the hidden form is shown when clicking the proper button' do
    visit thing_url(things(:thing1))

    click_on I18n.t('comments.new')

    assert_text I18n.t('tags.new-action'), count: 1

    click_on I18n.t('general.cancel')

    assert_text I18n.t('tags.new-action'), count: 0
  end

  test 'things#show: you can add a new comment' do
    visit thing_url(things(:thing1))

    click_on I18n.t('comments.new')
    find(:css, '#comment_content').set('a new comment')
    find("#comment_tag_ids_#{tags(:tag1).id}").click
    find("#comment_tag_ids_#{tags(:tag2).id}").click

    click_on I18n.t('helpers.submit.create')

    assert_text 'a new comment'
    assert_text "#{I18n.t('tags.title')}: #{tags(:tag1).name}, #{tags(:tag2).name}"
    assert_equal page.current_path, thing_path(things(:thing1))
  end

  test 'things#show: you can update a comment' do
    visit thing_url(things(:thing1))

    click_on I18n.t('general.edit').capitalize
    find(:css, '#comment_content').set('updated comment')

    find("#comment_#{comments(:comment1).id} input[type=submit]").click

    assert_text 'updated comment'
    assert_equal page.current_path, thing_path(things(:thing1))
  end

  test 'things#show: you can delete a comment' do
    visit thing_url(things(:thing1))

    all('.delete-comment').last.click

    assert_text I18n.t('comments.none')
    assert_equal page.current_path, thing_path(things(:thing1))
  end

  ##
  # In things#edit

  test 'things#edit: the hidden form is shown when clicking the proper button' do
    visit edit_thing_url(things(:thing1))

    click_on I18n.t('comments.new')

    assert_text I18n.t('tags.new-action'), count: 2

    click_on I18n.t('general.cancel')

    assert_text I18n.t('tags.new-action'), count: 1
  end

  test 'things#edit: you can add a new comment' do
    visit edit_thing_url(things(:thing1))

    click_on I18n.t('comments.new')
    find(:css, '#comment_content').set('a new comment')
    find("#comment_tag_ids_#{tags(:tag1).id}").click
    find("#comment_tag_ids_#{tags(:tag2).id}").click

    click_on I18n.t('helpers.submit.create')

    assert_text 'a new comment'
    assert_text "#{I18n.t('tags.title')}: #{tags(:tag1).name}, #{tags(:tag2).name}"
    assert_equal page.current_path, edit_thing_path(things(:thing1))
  end

  test 'things#edit: you can update a comment' do
    visit edit_thing_url(things(:thing1))

    click_on I18n.t('general.edit').capitalize
    find(:css, '#comment_content').set('updated comment')

    find("#comment_#{comments(:comment1).id} input[type=submit]").click

    assert_text 'updated comment'
    assert_equal page.current_path, edit_thing_path(things(:thing1))
  end

  test 'things#edit: you can delete a comment' do
    visit edit_thing_url(things(:thing1))

    all('.delete-comment').last.click

    assert_text I18n.t('comments.none')
    assert_equal page.current_path, edit_thing_path(things(:thing1))
  end
end
