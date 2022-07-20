<script setup lang="ts">
import { RouterLink, RouterView } from "vue-router";
import Language from "./views/LanguageView.vue";
</script>

<template>
  <div>
    <Language></Language>
    <RouterView />
  </div>
</template>

<script lang="ts">
export default {
  name: "App",
  components: {
    Language,
  },

  data() {
    return {
      message: "",
      kind: "",
    };
  },

  methods: {
    flash(kind, message) {
      this.kind = kind;
      this.message = message;
    },
  },

  computed: {
    sanitizedMessage() {
      if (this.message === "") {
        return "Unknown error";
      } else {
        return this.message;
      }
    },
  },
};
</script>

<style>
body {
  background-color: #fff;
  color: #333;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>
