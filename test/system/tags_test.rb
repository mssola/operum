# frozen_string_literal: true

require 'application_system_test_case'

class SharedSearchesTest < ApplicationSystemTestCase
  setup { sign_in! }

  test 'lists all the tags' do
    visit tags_url

    tags.each { |t| assert_text t.name }
  end

  test 'can create a new tag' do
    visit new_tag_url

    fill_in I18n.t('activerecord.attributes.tag.name'), with: 'whatever'
    assert_difference 'Tag.count' do
      click_on I18n.t('helpers.submit.create')

      assert_text 'whatever'
    end
  end

  test 'gives feedback on create errors' do
    visit new_tag_url

    fill_in I18n.t('activerecord.attributes.tag.name'), with: tags(:tag1).name
    click_on I18n.t('helpers.submit.create')

    assert_text "#{I18n.t('activerecord.attributes.tag.name')} #{I18n.t('errors.messages.taken')}"
  end

  test 'can visit the edit_tag path from #index' do
    visit tags_url

    click_link(I18n.t('general.edit'), match: :first)

    assert_text I18n.t('tags.update')
  end

  test 'can update a tag' do
    visit edit_tag_url(tags(:tag1))

    fill_in I18n.t('activerecord.attributes.tag.name'), with: "#{tags(:tag1).name}-updated"
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('tags.update-success')
    assert_text "#{tags(:tag1).name}-updated"
  end

  test 'gives feedback on update errors' do
    visit edit_tag_url(tags(:tag1))

    fill_in I18n.t('activerecord.attributes.tag.name'), with: tags(:tag2).name
    click_on I18n.t('helpers.submit.update')

    assert_text "#{I18n.t('activerecord.attributes.tag.name')} #{I18n.t('errors.messages.taken')}"
  end

  test 'can delete an existing tag' do
    visit tags_url

    assert_difference 'Tag.count', -1 do
      click_link(I18n.t('general.delete'), match: :first)

      assert_text I18n.t('tags.title')
    end
  end
end
