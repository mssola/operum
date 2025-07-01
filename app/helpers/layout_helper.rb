# frozen_string_literal: true

module LayoutHelper
  # Returns a strign containing the string to be used for the <title> HTML tag.
  def page_title
    title = ENV.fetch('OPERUM_BASE_TITLE', 'Operum')

    if @subtitle
      "#{@subtitle} - #{title}"
    else
      title
    end
  end
end
