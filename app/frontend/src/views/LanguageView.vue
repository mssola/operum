<template>
  <div class="hidden">
    <!-- filter -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.books">Books</span>
    <span v-else id="msg.ca.books">Llibres</span>

    <!-- filter -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.filter">Filter</span>
    <span v-else id="msg.ca.filter">Filtra</span>

    <!-- read -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.read">Read</span>
    <span v-else id="msg.ca.read">Llegits</span>

    <!-- notread -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.notread">Not read</span>
    <span v-else id="msg.ca.notread">No llegits</span>

    <!-- tobuy -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.tobuy">To buy</span>
    <span v-else id="msg.ca.tobuy">Per comprar</span>

    <!-- selected -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.selected"
      >Selected</span
    >
    <span v-else id="msg.ca.selected">Seleccionats</span>

    <!-- tobepublished -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.tobepublished"
      >To be published</span
    >
    <span v-else id="msg.ca.tobepublished">Per ser publicats</span>

    <!-- notspecified -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.notspecified"
      >Not specified</span
    >
    <span v-else id="msg.ca.notspecified">Sense especificar</span>

    <!-- none -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.none">Any</span>
    <span v-else id="msg.ca.none">General</span>

    <!-- poetry -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.poetry">Poetry</span>
    <span v-else id="msg.ca.poetry">Poesia</span>

    <!-- theater -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.theater">Theater</span>
    <span v-else id="msg.ca.theater">Teatre</span>

    <!-- essay -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.essay">Essay</span>
    <span v-else id="msg.ca.essay">Assaig</span>

    <!-- shorts -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.shorts">Shorts</span>
    <span v-else id="msg.ca.shorts">Curts</span>

    <!-- sortbyinterest -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.sortbyinterest"
      >Sort by interest</span
    >
    <span v-else id="msg.ca.sortbyinterest">Ordernar per interès</span>

    <!-- sortbydate -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.sortbydate"
      >Sort by date</span
    >
    <span v-else id="msg.ca.sortbydate">Ordernar per data</span>

    <!-- title -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.title">Title</span>
    <span v-else id="msg.ca.title">Títol</span>

    <!-- kind -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.kind">Kind</span>
    <span v-else id="msg.ca.kind">Tipus</span>

    <!-- author -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.author">Author</span>
    <span v-else id="msg.ca.author">Autor</span>

    <!-- insideof -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.insideof"
      >inside of</span
    >
    <span v-else id="msg.ca.insideof">dins de</span>

    <!-- insideofup -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.insideofup"
      >Inside of</span
    >
    <span v-else id="msg.ca.insideofup">Dins de</span>

    <!-- publisher -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.publisher"
      >Publisher</span
    >
    <span v-else id="msg.ca.publisher">Editorial</span>

    <!-- language -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.language"
      >Language</span
    >
    <span v-else id="msg.ca.language">Idioma</span>

    <!-- location -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.location"
      >Location</span
    >
    <span v-else id="msg.ca.location">Lloc</span>

    <!-- rate -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.rate">Rate</span>
    <span v-else id="msg.ca.rate">Qualificació</span>

    <!-- status -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.status">Status</span>
    <span v-else id="msg.ca.status">Estat</span>

    <!-- boughtat -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.boughtat"
      >Bought at</span
    >
    <span v-else id="msg.ca.boughtat">Comprat el</span>

    <!-- notes -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.notes">Notes</span>
    <span v-else id="msg.ca.notes">Notes</span>

    <!-- new -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.new">New</span>
    <span v-else id="msg.ca.new">Nou</span>

    <!-- create -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.create">Create</span>
    <span v-else id="msg.ca.create">Crea</span>

    <!-- update -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.update">Update</span>
    <span v-else id="msg.ca.update">Actualitza</span>

    <!-- edit -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.edit">Edit</span>
    <span v-else id="msg.ca.edit">Edita</span>

    <!-- cancel -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.cancel">Cancel</span>
    <span v-else id="msg.ca.cancel">Cancel·la</span>

    <!-- delete -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.delete">Delete</span>
    <span v-else id="msg.ca.delete">Elimina</span>

    <!-- confirm -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.confirm"
      >Are you sure about this?</span
    >
    <span v-else id="msg.ca.confirm">Estàs segur d'això?</span>

    <!-- error -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.error"
      >Something went wrong!</span
    >
    <span v-else id="msg.ca.error">Alguna cosa ha anat malament!</span>

    <!-- bad -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.bad">Bad request</span>
    <span v-else id="msg.ca.bad">Petició incorrecta</span>

    <!-- newbook -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.newbook">New book</span>
    <span v-else id="msg.ca.newbook">Llibre nou</span>

    <!-- clickmetoclose -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.clickmetoclose"
      >Click me to close!</span
    >
    <span v-else id="msg.ca.clickmetoclose">Fes click per tancar-me!</span>

    <!-- mandatory -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.mandatory"
      >Mandatory field</span
    >
    <span v-else id="msg.ca.mandatory">Camp obligatori</span>

    <!-- badrate -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.badrate"
      >Rate has to be between 0 and 10 (only integers)</span
    >
    <span v-else id="msg.ca.badrate"
      >La qualificació ha d'estar entre 0 i 10 (només enters)</span
    >

    <!-- logintitle -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.logintitle"
      >Sign in</span
    >
    <span v-else id="msg.ca.logintitle">Inicia la sessió</span>

    <!-- username -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.username"
      >User name</span
    >
    <span v-else id="msg.ca.username">Nom d'usuari</span>

    <!-- password -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.password"
      >Password</span
    >
    <span v-else id="msg.ca.password">Contrasenya</span>

    <!-- login -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.login">Login</span>
    <span v-else id="msg.ca.login">Entra</span>

    <!-- newuser -->
    <span v-if="i18n.getLanguage() === 'en'" id="msg.en.newuser">New user</span>
    <span v-else id="msg.ca.newuser">Nou usuari</span>
  </div>
</template>

<script>
import i18n from "../utils/i18n";

export default {
  name: "LanguageView",

  data() {
    return {
      i18n: i18n,
    };
  },

  created() {
    // TODO: revisit some of these messages.
    i18n.setCurrentLanguage();
    document.documentElement.setAttribute("lang", i18n.getLanguage());
  },
};
</script>
