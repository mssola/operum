# frozen_string_literal: true

json.groups do
  json.array! @groups, partial: 'groups/group', as: :group
end
