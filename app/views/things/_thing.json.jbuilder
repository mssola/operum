# frozen_string_literal: true

json.id thing.id
json.access thing.access
json.address thing.address
json.created_at thing.created_at
json.insideof thing.insideof
json.location thing.location
json.note thing.note
json.pages thing.pages
json.publisher thing.publisher
json.target thing.target
json.title thing.title
json.updated_at thing.updated_at
json.url thing.url
json.year thing.year
json.rate thing.rate
json.status thing.status
json.kind thing.kind
json.bought_at thing.bought_at

json.authors do
  json.array! thing.authors, partial: 'people/person', as: :person
end

json.translators do
  json.array! thing.translators, partial: 'people/person', as: :person
end

json.languages do
  json.array! thing.languages, partial: 'languages/language', as: :language
end

json.annotations do
  json.array! thing.annotations, partial: 'annotations/annotation', as: :annotation
end
