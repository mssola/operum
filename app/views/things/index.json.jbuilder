# frozen_string_literal: true

json.things do
  json.array! @things, partial: 'things/thing', as: :thing
end
