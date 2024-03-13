# frozen_string_literal: true

module SharedSearchesHelper
  # Returns `arg` as is if not blank, otherwise it returns '-'.
  def string_maybe(arg)
    arg.presence || '-'
  end

  # Format `ae.authors` depending on whether they are editors or not.
  def authors_or_editors(ae)
    if ae.editors
      "#{ae.authors} (eds.)"
    else
      ae.authors
    end
  end
end
