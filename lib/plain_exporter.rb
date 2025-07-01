# frozen_string_literal: true

# Plain text exporter.
class PlainExporter < BaseExporter
  def export
    @things.map { |thing| "#{head(thing:)} #{body(thing:)}".strip }.join("\n")
  end

  protected

  # Returns the same text as the plain exporter does not have formatting.
  def emph(text:)
    text
  end

  # Returns the same text as the plain exporter does not have formatting.
  def upper_case(text:)
    text
  end

  # Returns the same text with underscores stripped, as the plain exporter does
  # not have formatting.
  def parse_title(title:)
    title.delete('_')
  end

  # Returns text with information on the publisher, notes, year, address, etc;
  # if available.
  def body(thing:)
    str = ''

    if thing.publisher.present?
      str += thing.note.present? ? "#{thing.note}. #{thing.publisher}" : thing.publisher
    end

    if thing.address.present?
      str + ", #{thing.address}: #{thing.year}."
    else
      "#{str}."
    end
  end
end
