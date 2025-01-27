# frozen_string_literal: true

# Helper functions for dealing with titles of Things.
module TitleHelper
  # Returns the given string with underscores to <em></em>.
  def title_to_html(title:)
    replace_underscores_with(string: title, open_char: '<em>', close_char: '</em>').html_safe # rubocop:disable Rails/OutputSafety
  end

  # Replace underscores from a string with the given open/close characters.
  def replace_underscores_with(string:, open_char:, close_char:)
    string.gsub(/_([^_]+)_/, "#{open_char}\\1#{close_char}")
  end
end
