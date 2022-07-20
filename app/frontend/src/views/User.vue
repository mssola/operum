<template>
  <NamePassword :action="user"></NamePassword>
</template>

<script lang="ts">
import NamePassword from "../components/NamePassword.vue";

export default {
  name: "UserView",

  components: {
    NamePassword,
  },
};
</script>
