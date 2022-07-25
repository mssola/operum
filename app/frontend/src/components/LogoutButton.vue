<template>
  <div>
    <button id="logout" class="btn btn-basic w-full mt-2 mb-2" @click="logout">
      {{ i18n.t("logout") }}
    </button>
  </div>
</template>

<script>
import i18n from "../utils/i18n";
import { tokenStore } from "../stores/token.ts";

export default {
  name: "LogoutButton",

  data() {
    return {
      i18n,
    };
  },

  setup() {
    const store = tokenStore();
    return { store };
  },

  methods: {
    logout() {
      this.store.token = "";
      this.$router.go();
    },
  },
};
</script>
