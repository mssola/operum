# frozen_string_literal: true

require 'application_system_test_case'

class ThingsTest < ApplicationSystemTestCase
  setup { sign_in! }

  test 'the hidden menu has a things#new link' do
    find('#toggle-hidden-global-menu').click

    assert_text I18n.t('things.object').downcase

    click_on I18n.t('things.object').downcase

    assert_text I18n.t('activerecord.attributes.thing.title')

    assert_equal page.current_path, new_thing_path
  end

  test 'you can click on a thing listed on the search to go to the its #show page' do
    click_on things(:thing1).title

    assert_text I18n.t('activerecord.attributes.thing.title')

    assert_equal page.current_path, edit_thing_path(things(:thing1))
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

    assert_equal tags.map(&:name), [tags(:tag1).name]
  end

  test 'you have a link to go back at creating a thing' do
    visit thing_url(things(:thing1))

    click_on I18n.t('things.create-another')

    assert_text I18n.t('activerecord.attributes.thing.title')
    assert_equal page.current_path, new_thing_path
  end

  test 'you get feedback from wrong values for a new thing' do
    visit new_thing_url

    fill_in I18n.t('activerecord.attributes.thing.title'), with: 'whatever title'
    fill_in I18n.t('activerecord.attributes.thing.authors'), with: 'author'
    fill_in I18n.t('activerecord.attributes.thing.target'), with: things(:thing1).target
    fill_in I18n.t('activerecord.attributes.thing.rate'), with: 5
    find("#thing_tag_ids_#{tags(:tag1).id}").click

    click_on I18n.t('helpers.submit.create')

    assert_text "#{I18n.t('activerecord.attributes.thing.target')} " \
                "#{I18n.t('errors.messages.taken')}"
  end

  test 'you can update a value from a thing' do
    visit edit_thing_url(things(:thing1))

    # Originally :thing1 has references to :tag1 and :tag2. This test will
    # remove the reference to :tag1.
    assert_equal 2, things(:thing1).tag_references.size

    fill_in I18n.t('activerecord.attributes.thing.title'), with: 'another thing entirely'
    find("#thing_tag_ids_#{tags(:tag1).id}").click
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('things.update-success')

    # Tag references updated: only one reference (:tag2).
    tags = things(:thing1).reload.tags

    assert_equal tags.map(&:id), [tags(:tag2).id]
  end

  test 'you get feedback from wrong values when updating a thing' do
    visit edit_thing_url(things(:thing1))

    fill_in I18n.t('activerecord.attributes.thing.target'), with: things(:thing2).target
    click_on I18n.t('helpers.submit.update')

    assert_text "#{I18n.t('activerecord.attributes.thing.target')} " \
                "#{I18n.t('errors.messages.taken')}"
  end

  test 'you can delete a thing' do
    visit edit_thing_url(things(:thing1))

    assert_difference 'Thing.count', -1 do
      accept_alert { click_on I18n.t('general.delete').capitalize, match: :first }

      assert_text I18n.t('things.destroy-success')
    end
  end

  test '"access" appears/disappears whenever "url" is set/unset' do
    visit edit_thing_url(things(:thing1))

    assert_text I18n.t('activerecord.attributes.thing.access')

    fill_in I18n.t('activerecord.attributes.thing.url'), with: ''

    assert_text I18n.t('activerecord.attributes.thing.access'), count: 0

    fill_in I18n.t('activerecord.attributes.thing.url'), with: 'whatever'

    assert_text I18n.t('activerecord.attributes.thing.access')
  end

  test '"target" gets generated from last name' do
    visit new_thing_url

    fill_in I18n.t('activerecord.attributes.thing.authors'), with: 'Name LastName'

    text = find_field(I18n.t('activerecord.attributes.thing.target')).value

    assert_equal 'LastName', text
  end

  test '"target" gets generated from last name and year' do
    visit new_thing_url

    fill_in I18n.t('activerecord.attributes.thing.authors'), with: 'Name LastName'
    fill_in I18n.t('activerecord.attributes.thing.year'), with: '2024'

    text = find_field(I18n.t('activerecord.attributes.thing.target')).value

    assert_equal 'LastName2024', text
  end

  test '"target" gets generated from multiple names and year' do
    visit new_thing_url

    fill_in I18n.t('activerecord.attributes.thing.authors'), with: 'Name LastName, John Smith'
    fill_in I18n.t('activerecord.attributes.thing.year'), with: '2024'

    text = find_field(I18n.t('activerecord.attributes.thing.target')).value

    assert_equal 'LastNameSmith2024', text
  end
end
