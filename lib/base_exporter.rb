# frozen_string_literal: true

class BaseExporter
  def initialize(things:)
    @things = things
  end

  # Returns a string which forces a new TeX line.
  def tex_new_line
    '\\\\~\\\\'
  end

  # Returns a two-sized array containing the first name and the last name as
  # parsed from the `author` string. This method assumes the following format is
  # followed:
  #   - 'Name' -> ['Name', nil]
  #   - 'Name Surname' -> ['Name', 'Surname']
  #   - 'Compound Name Surname' -> ['Compound Name', 'Surname']
  #   - 'Name _Surname1 Surname2_' -> ['Name', 'Surname1 Surname2']
  def parse_author(author:)
    matches = /(.+)?\s_(.+)_/.match(author)
    return matches[1].strip, matches[2].strip if matches&.size == 3

    a = author.split
    return [author, nil] if a.size == 1

    [a[0..-2].join(' '), a.last]
  end
end
