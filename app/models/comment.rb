# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :thing

  has_many :tag_references, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_references

  has_rich_text :content

  # Returns all comments which have a content matching the given text.
  def self.like(text:)
    Comment.joins(:rich_text_content)
           .where('action_text_rich_texts.body LIKE ?', "%#{text}%")
  end
end
