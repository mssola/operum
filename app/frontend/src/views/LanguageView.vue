<template>
  <div class="hidden">
    <!-- filter -->
    <span id="msg.en.books">Books</span>
    <span id="msg.ca.books">Llibres</span>

    <!-- filter -->
    <span id="msg.en.filter">Filter</span>
    <span id="msg.ca.filter">Filtra</span>

    <!-- read -->
    <span id="msg.en.read">Read</span>
    <span id="msg.ca.read">Llegits</span>

    <!-- notread -->
    <span id="msg.en.notread">Not read</span>
    <span id="msg.ca.notread">No llegits</span>

    <!-- tobuy -->
    <span id="msg.en.tobuy">To buy</span>
    <span id="msg.ca.tobuy">Per comprar</span>

    <!-- selected -->
    <span id="msg.en.selected">Selected</span>
    <span id="msg.ca.selected">Seleccionats</span>

    <!-- tobepublished -->
    <span id="msg.en.tobepublished">To be published</span>
    <span id="msg.ca.tobepublished">Per ser publicats</span>

    <!-- notspecified -->
    <span id="msg.en.notspecified">Not specified</span>
    <span id="msg.ca.notspecified">Sense especificar</span>

    <!-- none -->
    <span id="msg.en.none">Any</span>
    <span id="msg.ca.none">General</span>

    <!-- poetry -->
    <span id="msg.en.poetry">Poetry</span>
    <span id="msg.ca.poetry">Poesia</span>

    <!-- theater -->
    <span id="msg.en.theater">Theater</span>
    <span id="msg.ca.theater">Teatre</span>

    <!-- essay -->
    <span id="msg.en.essay">Essay</span>
    <span id="msg.ca.essay">Assaig</span>

    <!-- shorts -->
    <span id="msg.en.shorts">Shorts</span>
    <span id="msg.ca.shorts">Curts</span>

    <!-- sortbyinterest -->
    <span id="msg.en.sortbyinterest">Sort by interest</span>
    <span id="msg.ca.sortbyinterest">Ordernar per interès</span>

    <!-- sortbydate -->
    <span id="msg.en.sortbydate">Sort by date</span>
    <span id="msg.ca.sortbydate">Ordernar per data</span>

    <!-- title -->
    <span id="msg.en.title">Title</span>
    <span id="msg.ca.title">Títol</span>

    <!-- kind -->
    <span id="msg.en.kind">Kind</span>
    <span id="msg.ca.kind">Tipus</span>

    <!-- author -->
    <span id="msg.en.author">Author</span>
    <span id="msg.ca.author">Autor</span>

    <!-- insideof -->
    <span id="msg.en.insideof">inside of</span>
    <span id="msg.ca.insideof">dins de</span>

    <!-- insideofup -->
    <span id="msg.en.insideofup">Inside of</span>
    <span id="msg.ca.insideofup">Dins de</span>

    <!-- publisher -->
    <span id="msg.en.publisher">Publisher</span>
    <span id="msg.ca.publisher">Editorial</span>

    <!-- language -->
    <span id="msg.en.language">Language</span>
    <span id="msg.ca.language">Idioma</span>

    <!-- location -->
    <span id="msg.en.location">Location</span>
    <span id="msg.ca.location">Lloc</span>

    <!-- rate -->
    <span id="msg.en.rate">Rate</span>
    <span id="msg.ca.rate">Qualificació</span>

    <!-- status -->
    <span id="msg.en.status">Status</span>
    <span id="msg.ca.status">Estat</span>

    <!-- boughtat -->
    <span id="msg.en.boughtat">Bought at</span>
    <span id="msg.ca.boughtat">Comprat el</span>

    <!-- notes -->
    <span id="msg.en.notes">Notes</span>
    <span id="msg.ca.notes">Notes</span>

    <!-- new -->
    <span id="msg.en.new">New</span>
    <span id="msg.ca.new">Nou</span>

    <!-- create -->
    <span id="msg.en.create">Create</span>
    <span id="msg.ca.create">Crea</span>

    <!-- update -->
    <span id="msg.en.update">Update</span>
    <span id="msg.ca.update">Actualitza</span>

    <!-- edit -->
    <span id="msg.en.edit">Edit</span>
    <span id="msg.ca.edit">Edita</span>

    <!-- cancel -->
    <span id="msg.en.cancel">Cancel</span>
    <span id="msg.ca.cancel">Cancel·la</span>

    <!-- delete -->
    <span id="msg.en.delete">Delete</span>
    <span id="msg.ca.delete">Elimina</span>

    <!-- confirm -->
    <span id="msg.en.confirm">Are you sure about this?</span>
    <span id="msg.ca.confirm">Estàs segur d'això?</span>

    <!-- error -->
    <span id="msg.en.error">Something went wrong!</span>
    <span id="msg.ca.error">Alguna cosa ha anat malament!</span>

    <!-- bad -->
    <span id="msg.en.bad">Bad request</span>
    <span id="msg.ca.bad">Petició incorrecta</span>

    <!-- newbook -->
    <span id="msg.en.newbook">New book</span>
    <span id="msg.ca.newbook">Llibre nou</span>

    <!-- clickmetoclose -->
    <span id="msg.en.clickmetoclose">Click me to close!</span>
    <span id="msg.ca.clickmetoclose">Fes click per tancar-me!</span>

    <!-- mandatory -->
    <span id="msg.en.mandatory">Mandatory field</span>
    <span id="msg.ca.mandatory">Camp obligatori</span>

    <!-- badrate -->
    <span id="msg.en.badrate"
      >Rate has to be between 0 and 10 (only integers)</span
    >
    <span id="msg.ca.badrate"
      >La qualificació ha d'estar entre 0 i 10 (només enters)</span
    >

    <!-- logintitle -->
    <span id="msg.en.logintitle">Sign in</span>
    <span id="msg.ca.logintitle">Inicia la sessió</span>

    <!-- username -->
    <span id="msg.en.username">User name</span>
    <span id="msg.ca.username">Nom d'usuari</span>

    <!-- password -->
    <span id="msg.en.password">Password</span>
    <span id="msg.ca.password">Contrasenya</span>

    <!-- login -->
    <span id="msg.en.login">Login</span>
    <span id="msg.ca.login">Entra</span>

    <!-- newuser -->
    <span id="msg.en.newuser">New user</span>
    <span id="msg.ca.newuser">Nou usuari</span>
  </div>
</template>

<script>
import i18n from "../utils/i18n";

export default {
  name: "LanguageView",

  mounted() {
    // TODO: don't show *everything* but put v-if's
    i18n.setCurrentLanguage();
  },
};
</script>
