# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :things, dependent: :destroy
  has_many :groups, dependent: :destroy
end
