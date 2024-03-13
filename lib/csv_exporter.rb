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

  def thing_to_csv(thing:)
    CSV.generate_line([thing.target, thing.authors, thing.editors, thing.year, thing.title,
                       thing.note, thing.insideof, thing.url, thing.publisher, thing.kind,
                       thing.access, thing.bought_at],
                      quote_empty: false)
  end
end
