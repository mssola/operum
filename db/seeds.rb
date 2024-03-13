# frozen_string_literal: true

return unless Rails.env == 'development'

u = User.find_by(username: 'user')
unless u
  u = User.new(username: 'user', password: '12341234', password_confirmation: '12341234')
  u.save!
end

##
# Books, articles, whatever.

[
  {
    target: 'Rossich2006',
    title: 'Poesia catalana del barroc. Antologia',
    authors: 'Albert Rossich, Pep Valsalobre',
    publisher: 'Edicions Vitel·la',
    address: "Bellcaire d'Empordà",
    year: 2006,
    kind: Thing.kinds[:poetry],
    status: Thing.statuses[:read],
    rate: 10,
    user: u
  },
  {
    target: 'OvidiMetamorfosisParramon',
    title: 'Metamorfosis',
    authors: 'Ovidi',
    publisher: 'Quaderns Crema',
    address: 'Barcelona',
    note: 'Traducció en versos a càrrec de Jordi Parramon',
    year: 2000,
    kind: Thing.kinds[:poetry],
    status: Thing.statuses[:read],
    rate: 10,
    user: u
  },
  {
    target: 'Rossich2023',
    title: "Sou lo que podeu mostrar que haveu begut d'aquesta font",
    authors: 'Eulàlia Miralles, Marc Sogues, Pep Valsalobre',
    editors: true,
    publisher: 'Editorial Afers',
    address: 'Catarroja - Barcelona',
    note: 'Homenatge al professor Albert Rossich',
    year: 2023,
    kind: Thing.kinds[:essay],
    status: Thing.statuses[:notread],
    rate: 10,
    user: u
  },
  {
    target: 'EuripidesIX2',
    title: "Tragèdies. IX, 2",
    authors: 'Eurípides',
    publisher: 'Fundació Bernat Metge',
    address: 'Barcelona',
    note: 'Ifigènia a Àulida',
    year: 2023,
    kind: Thing.kinds[:theater],
    status: Thing.statuses[:notread],
    rate: 10,
    user: u
  },
  {
    target: 'RodoredaContes',
    title: "Tots els contes",
    authors: 'Mercè Rodoreda',
    publisher: 'Edicions 62 - labutxaca',
    address: 'Barcelona',
    note: 'Segona edició',
    year: 2017,
    kind: Thing.kinds[:shorts],
    status: Thing.statuses[:read],
    rate: 8,
    user: u
  },
  {
    target: 'CussaEmperador',
    title: 'El primer emperador i la reina Lluna',
    authors: 'Jordi Cussà',
    publisher: 'Comanegra',
    address: 'Barcelona',
    note: '',
    year: 2020,
    kind: Thing.kinds[:novel],
    status: Thing.statuses[:read],
    rate: 9,
    user: u
  }
].each { |params| Thing.find_or_create_by!(params) }

##
# Comments

Thing.find_by(target: 'Rossich2006').comments.find_or_create_by!(content: 'Primer comentari a Rossich')
Thing.find_by(target: 'Rossich2006').comments.find_or_create_by!(content: 'Segon comentari a Rossich')

##
# Tags

['Per llegir', 'Moderna', 'Clàssiques', 'TFG'].each { |t| Tag.find_or_create_by!(name: t) }

##
# Tag references

Thing.find_by(target: 'Rossich2006').tag_references.find_or_create_by!(tag: Tag.find_by(name: 'Moderna'))
Thing.find_by(target: 'Rossich2006').tag_references.find_or_create_by!(tag: Tag.find_by(name: 'TFG'))
Thing.find_by(target: 'OvidiMetamorfosisParramon').tag_references.find_or_create_by!(tag: Tag.find_by(name: 'Clàssiques'))
Thing.find_by(target: 'OvidiMetamorfosisParramon').tag_references.find_or_create_by!(tag: Tag.find_by(name: 'TFG'))
Comment.find(1).tag_references.find_or_create_by!(tag: Tag.find_by(name: 'TFG'))

##
# Searches

Search.find_or_create_by!(name: 'tfg', body: 'tag:"TFG"', user: u)
