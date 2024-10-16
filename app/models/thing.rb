# frozen_string_literal: true

class Thing < ApplicationRecord
  validates :target, presence: true, uniqueness: true
  validates :title, presence: true
  validates :authors, presence: true
  validates :rate, numericality: { in: 0..10 }

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :tag_references, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_references

  enum :status, { read: 0, notread: 1, tobepublished: 2 }, validate: true
  enum :kind, { other: 0, poetry: 1, theater: 2, essay: 3,
                shorts: 4, novel: 5, paper: 6, letters: 7,
                phd: 8, chronicle: 9, bio: 10, it: 11 }, validate: true

  # Returns all things which match the given text for any of the string columns
  # from the table.
  def self.like(text:)
    Thing.where('target LIKE ?', "%#{text}%")
         .or(where('title LIKE ?', "%#{text}%"))
         .or(where('publisher LIKE ?', "%#{text}%"))
         .or(where('address LIKE ?', "%#{text}%"))
         .or(where('url LIKE ?', "%#{text}%"))
         .or(where('insideof LIKE ?', "%#{text}%"))
         .or(where('pages LIKE ?', "%#{text}%"))
         .or(where('note LIKE ?', "%#{text}%"))
         .or(where('authors LIKE ?', "%#{text}%"))
  end
end
