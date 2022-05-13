# frozen_string_literal: true

class Thing < ApplicationRecord
  validates :target, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true

  belongs_to :user

  has_many :thing_people, dependent: :destroy

  has_many :thing_languages, dependent: :destroy
  has_many :languages, through: :thing_languages, dependent: :destroy

  has_many :annotations, dependent: :destroy

  enum :status, %i[read notread tobuy selected tobepublished]
  enum :kind, %i[other poetry theater essay shorts]

  def authors
    Person.find(thing_people.where(role: ThingPerson.roles[:author]).ids)
  end

  def translators
    Person.find(thing_people.where(role: ThingPerson.roles[:translator]).ids)
  end

  def add_people!(authors:, translators:)
    authors.each do |author|
      ThingPerson.create!(thing: self, person: Person.find(author))
    end

    translators.each do |author|
      ThingPerson.create!(thing: self, person: Person.find(author))
    end
  end

  # TODO: does this really work? If so, modify the `add_people!` method so it
  # picks up an array of `person``.
  def update_people!(authors:, translators:)
    ActiveRecord::Base.transaction do
      ThingPerson.destroy!(thing: self, person: authors)
      ThingPerson.destroy!(thing: self, person: translators)

      add_people!(authors:, translators:)
    end
  end
end
