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
    CSV.generate_line([thing.target, thing.authors, thing.editors, thing.year,
                       clean_title(title: thing.title), thing.note, thing.insideof,
                       thing.url, thing.publisher, thing.kind, thing.access, thing.bought_at],
                      quote_empty: false)
  end

  # Clean the given title from underscores and other such characters.
  def clean_title(title:)
    title.delete('_')
  end
end
