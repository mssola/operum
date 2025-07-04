# frozen_string_literal: true

class UocExporter < BaseExporter
  def export
    @things.map.with_index do |thing, idx|
      if idx.zero?
        "\\hypertarget{#{thing.target}}{#{head(thing:)} #{body(thing:)}}"
      else
        "#{tex_new_line}\\hypertarget{#{thing.target}}{#{head(thing:)} #{body(thing:)}}"
      end
    end.join("\n\n")
  end

  protected

  # Returns the same text with LaTeX \emph applied.
  def emph(text:)
    "\\emph{#{text}}"
  end

  # Returns the same text with LaTeX \textsc applied.
  def upper_case(text:)
    "\\textsc{#{text}}"
  end

  # Returns the title without underscores and with the expected formatting.
  def parse_title(title:)
    str = ''
    seen = false

    # I'm sure there is a clever (and comboluted) regexp that can also achieve
    # this, but after some tries I decided to cut the crap.
    title.each_char do |c|
      if c == '_'
        str += seen ? '\emph{' : '}'
        seen = !seen
      else
        str += c
      end
    end

    "\\emph{#{str}}"
  end

  # Returns the 'body' of the line, which is the rest of it (i.e. note,
  # publisher, year).
  def body(thing:)
    union, tail = thing_union_tail(thing:)

    if thing.publisher.present?
      pub = thing.note.present? ? "#{thing.note}. #{thing.publisher}" : thing.publisher
      pub + union + tail
    else
      tail
    end
  end

  # Returns a two-sized array containing the last bits of info from a line,
  # being either the address, the url + access date, or just a final dot. The
  # first item contains the 'union' of the last item of the returned array and
  # the expected string that is going to be prefixed to it.
  def thing_union_tail(thing:)
    if thing.address.present?
      [', ', "#{thing.address}: #{thing.year}."]
    elsif thing.url.present?
      ['. ',
       "[\\url{#{thing.url}}]. [#{I18n.t('activerecord.attributes.thing.access')}: #{I18n.l(
         thing.access, format: :long
       ).downcase}]."]
    else
      ['', '.']
    end
  end
end
