# frozen_string_literal: true

require 'application_system_test_case'

class ThingsTest < ApplicationSystemTestCase
  setup { sign_in! }

  test 'the hidden menu has a things#new link' do
    find('#toggle-hidden-global-menu').click
    assert_text I18n.t('things.object').downcase

    click_on I18n.t('things.object').downcase
    assert_text I18n.t('activerecord.attributes.thing.title')

    assert page.current_path == new_thing_path
  end

  test 'you can click on a thing listed on the search to go to the its #show page' do
    click_on things(:thing1).title

    assert_text I18n.t('activerecord.attributes.thing.title')

    assert page.current_path == edit_thing_path(things(:thing1))
  end

  test 'you can create a new thing' do
    visit new_thing_url

    fill_in I18n.t('activerecord.attributes.thing.title'), with: 'new title'
    fill_in I18n.t('activerecord.attributes.thing.authors'), with: 'author'
    fill_in I18n.t('activerecord.attributes.thing.target'), with: 'identifier'
    fill_in I18n.t('activerecord.attributes.thing.rate'), with: 5
    find("#thing_tag_ids_#{tags(:tag1).id}").click

    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('things.create-success')

    # Ensure that tag references are properly created.
    tags = Thing.find_by(title: 'new title').tags
    assert tags.size == 1
    assert tags.first.name == tags(:tag1).name

    # You can go back to create another thing with a convenient link.
    click_on I18n.t('things.create-another')
    assert_text I18n.t('activerecord.attributes.thing.title')
    assert page.current_path == new_thing_path
  end

  test 'you get feedback from wrong values for a new thing' do
    visit new_thing_url

    fill_in I18n.t('activerecord.attributes.thing.title'), with: things(:thing1).title
    fill_in I18n.t('activerecord.attributes.thing.authors'), with: 'author'
    fill_in I18n.t('activerecord.attributes.thing.target'), with: 'identifier'
    fill_in I18n.t('activerecord.attributes.thing.rate'), with: 5
    find("#thing_tag_ids_#{tags(:tag1).id}").click

    click_on I18n.t('helpers.submit.create')

    assert_text "#{I18n.t('activerecord.attributes.thing.title')} " \
                "#{I18n.t('errors.messages.taken')}"
  end

  test 'you can update a value from a thing' do
    visit edit_thing_url(things(:thing1))

    # Originally :thing1 has references to :tag1 and :tag2. This test will
    # remove the reference to :tag1.
    assert things(:thing1).tag_references.size == 2

    fill_in I18n.t('activerecord.attributes.thing.title'), with: 'another thing entirely'
    find("#thing_tag_ids_#{tags(:tag1).id}").click
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('things.update-success')

    # Tag references updated: only one reference (:tag2).
    tags = things(:thing1).reload.tags
    assert tags.size == 1
    assert tags.first.id = tags(:tag2).id
  end

  test 'you get feedback from wrong values for a thing' do
    visit edit_thing_url(things(:thing1))

    fill_in I18n.t('activerecord.attributes.thing.title'), with: things(:thing2).title
    click_on I18n.t('helpers.submit.update')

    assert_text "#{I18n.t('activerecord.attributes.thing.title')} " \
                "#{I18n.t('errors.messages.taken')}"
  end

  test 'you can delete a thing' do
    visit edit_thing_url(things(:thing1))

    assert_difference 'Thing.count', -1 do
      accept_alert { click_on I18n.t('general.delete').capitalize, match: :first }
      assert_text I18n.t('things.destroy-success')
    end
  end
end
