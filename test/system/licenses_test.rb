# frozen_string_literal: true

require 'application_system_test_case'

class LicensesTest < ApplicationSystemTestCase
  test 'can reach #show without login' do
    visit license_url

    assert_text 'AGPLv3'
  end
end
