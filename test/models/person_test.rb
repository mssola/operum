# frozen_string_literal: true

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test '#clean_name removes all underscores' do
    expected = 'John Smithie Smith'

    [people(:one), people(:two), people(:three), people(:four)].each do |fixt|
      assert_equal fixt.clean_name, expected
    end
  end

  test '#to_reference works properly' do
    obj = people(:one).to_reference
    assert_equal obj[:name], 'John'
    assert_equal obj[:last], 'Smithie Smith'

    obj = people(:two).to_reference
    assert_equal obj[:name], 'John'
    assert_equal obj[:last], 'Smithie Smith'

    obj = people(:three).to_reference
    assert_equal obj[:name], 'John Smithie Smith'
    assert_equal obj[:last], ''

    obj = people(:four).to_reference
    assert_equal obj[:name], 'John Smithie'
    assert_equal obj[:last], ''

    obj = people(:five).to_reference
    assert_equal obj[:name], 'John'
    assert_equal obj[:last], ''
  end
end
