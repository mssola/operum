# frozen_string_literal: true

json.people do
  json.array! @people, partial: 'people/person', as: :person
end
