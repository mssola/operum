<template>
  <div class="about">
    <LogoutButton></LogoutButton>
    <h1>This is the books page</h1>
  </div>
</template>

<script lang="ts">
import LogoutButton from "../components/LogoutButton.vue";

export default {
  name: "BooksView",

  components: {
    LogoutButton,
  },
};
</script>

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
