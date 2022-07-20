<template>
  <div class="flex justify-center">
    <div class="w-full max-w-xs">
      <h1 class="text-2xl my-6">{{ title }}</h1>

      <div class="field">
        <label class="block text-gray-700 text-sm font-bold mb-1" for="username"
          >{{ i18n.t("username")
          }}<small class="mx-1" :title="`${i18n.t('mandatory')}`"
            >(*)</small
          ></label
        >

        <input
          id="username"
          class="rounded border border-gray-400 w-full"
          type="text"
          autocomplete="off"
          v-model="username"
        />
      </div>

      <div class="field">
        <label class="block text-gray-700 text-sm font-bold mb-1" for="password"
          >{{ i18n.t("password")
          }}<small class="mx-1" :title="`${i18n.t('mandatory')}`"
            >(*)</small
          ></label
        >

        <input
          id="password"
          class="rounded border border-gray-400 w-full"
          type="password"
          v-model="password"
        />
      </div>

      <div class="field">
        <button
          id="create"
          class="font-semibold py-2 px-4 rounded cursor-pointer bg-green-500 text-white border border-green-700 hover:bg-green-700 w-full mt-2 mb-2"
          :disabled="isDisabled"
          @click="doAction"
        >
          {{ button }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import i18n from "../utils/i18n";

export default {
  name: "NamePassword",

  props: {
    action: String,
  },

  data() {
    return {
      i18n,
      username: "",
      password: "",
    };
  },

  computed: {
    title() {
      return this.action === "login" ? i18n.t("logintitle") : i18n.t("newuser");
    },

    button() {
      return this.action === "login" ? i18n.t("login") : i18n.t("create");
    },

    isDisabled() {
      return this.username === "" || this.password === "";
    },
  },

  methods: {
    doAction() {
      console.log("HER!");
    },
  },
};
</script>
