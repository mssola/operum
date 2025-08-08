# frozen_string_literal: true

class BaseExporter
  def initialize(things:)
    @things = things
  end

  protected

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

  # Parse the string in `thing.authors` and put each author followed by
  # semicolon and the right order for first and last name. It will also cover
  # whenever editors are involved.
  def parse_authors(thing:)
    str = thing.authors.split(',').map do |author|
      first, last = parse_author(author: author.strip)
      last.blank? ? upper_case(text: first).to_s : "#{upper_case(text: last)}, #{first}"
    end.join('; ')

    str += ' (eds.)' if thing.editors
    str
  end

  # Returns an "Inside of" string where `sub` is the substring contained in it.
  def inside_of(sub:)
    str = if sub.downcase.start_with?(*%w[a e i o u])
            I18n.t('general.insideof-vowel')
          else
            I18n.t('general.insideof')
          end

    str + " #{emph(text: sub)}"
  end

  # Returns the head of a formatted "thing", containing authors, year, title
  # and, if available, the "inside of" information. This is shared across some
  # exporters, thus placed in here.
  #
  # NOTE: the subclass *must* implement `parse_title`.
  def head(thing:)
    str = if thing.year
            "#{parse_authors(thing:)} (#{thing.year}). #{parse_title(title: thing.title)}."
          else
            "#{parse_authors(thing:)}. #{parse_title(title: thing.title)}."
          end

    if thing.insideof.present?
      str += " #{inside_of(sub: thing.insideof)}"
      str += thing.pages.present? ? ", #{thing.pages}." : '.'
    end

    str
  end
end
