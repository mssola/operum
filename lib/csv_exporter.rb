# frozen_string_literal: true

require 'csv'

class CsvExporter < BaseExporter
  def export
    str = ''
    @things.each do |thing|
      str += thing_to_csv(thing:)
    end

    str
  end

  protected

  # Generate a new CSV line from the given `thing`.
  def thing_to_csv(thing:)
    CSV.generate_line([thing.target, thing.authors.delete('_'), thing.editors, thing.year,
                       thing.title.delete('_'), thing.note, thing.insideof,
                       thing.url, thing.publisher, thing.kind, thing.access, thing.bought_at],
                      quote_empty: false)
  end
end
