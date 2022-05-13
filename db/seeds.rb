# frozen_string_literal: true

%w[ca en].each do |code|
  Language.find_or_create_by(code: code)
end
