# frozen_string_literal: true

class Person < ApplicationRecord
  validates :full_name, presence: true, uniqueness: true

  has_many :thing_people, dependent: :destroy

  REFERENCE_FORMAT = /(.+)?_(.+)_/

  # Returns the full name without formatting characters.
  def clean_name
    full_name.delete('_')
  end

  # Returns a hash with `name` and `last` attributes describing the parsed
  # `full_name` column according to how the user formatted it.
  def to_reference
    matches = full_name.match(REFERENCE_FORMAT)

    if matches.nil?
      one, two = full_name.split(/\s/, 2)
      { name: one.strip, last: two.nil? ? '' : two.strip }
    else
      one = matches[1]
      two = matches[2]

      if one.nil?
        { name: two.strip, last: '' }
      else
        { name: one.strip, last: two.nil? ? '' : two.strip }
      end
    end
  end
end
