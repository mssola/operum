# frozen_string_literal: true

class Language < ApplicationRecord
  validates :code, presence: true, uniqueness: true

  def self.by_code!(codes)
    return [] if codes.blank?

    codes = [codes] unless codes.is_a?(Array)
    codes.map do |code|
      lang = Language.find_by(code:)
      # TODO: i18n
      if lang.blank?
        raise ActiveRecord::RecordNotFound,
              "could not find language with code '#{code}'"
      end

      lang
    end
  end
end
