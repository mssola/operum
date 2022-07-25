<template>
  <NamePassword action="login"></NamePassword>
</template>

<script lang="ts">
import NamePassword from "../components/NamePassword.vue";

export default {
  name: "LoginView",

  components: {
    NamePassword,
  },
};
</script>
