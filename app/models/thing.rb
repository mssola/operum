# frozen_string_literal: true

class Thing < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :target, presence: true, uniqueness: true
  validates :authors, presence: true
  validates :rate, numericality: { in: 0..10 }

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :tag_references, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_references

  enum :status, %i[read notread tobepublished], validate: true
  enum :kind, %i[other poetry theater essay shorts novel paper], validate: true

  # Returns all things which match the given text for any of the string columns
  # from the table.
  def self.like(text:)
    Thing.where('target LIKE ?', "%#{text}%")
         .or(where('title LIKE ?', "%#{text}%"))
         .or(where('publisher LIKE ?', "%#{text}%"))
         .or(where('address LIKE ?', "%#{text}%"))
         .or(where('url LIKE ?', "%#{text}%"))
         .or(where('location LIKE ?', "%#{text}%"))
         .or(where('insideof LIKE ?', "%#{text}%"))
         .or(where('pages LIKE ?', "%#{text}%"))
         .or(where('note LIKE ?', "%#{text}%"))
         .or(where('authors LIKE ?', "%#{text}%"))
  end
end
