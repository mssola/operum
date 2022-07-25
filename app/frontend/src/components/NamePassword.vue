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
          class="rounded border border-gray-400 w-full px-2 py-1"
          type="text"
          autocomplete="off"
          autofocus="autofocus"
          @keyup.enter="doAction"
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
          class="rounded border border-gray-400 w-full px-2 py-1"
          type="password"
          @keyup.enter="doAction"
          v-model="password"
        />
      </div>

      <div class="field">
        <button
          id="create"
          class="btn btn-new w-full mt-2 mb-2"
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
import axios from "axios";
import { tokenStore } from "../stores/token.ts";

export default {
  name: "NamePassword",

  props: {
    action: String,
  },

  setup() {
    const store = tokenStore();
    return { store };
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
      if (this.isDisabled) {
        return;
      }
      this.action === "login" ? this.doLogin() : this.doSignup();
    },

    doLogin() {
      axios({
        method: "POST",
        url: "/auth/login",
        data: { username: this.username, password: this.password },
        headers: {
          "Content-Type": "application/json",
        },
      })
        .then((resp) => {
          this.store.token = resp.data.token;
          this.$router.push("/");
        })
        .catch((e) => {
          // TODO: flash
          if (e.response.status === 401) {
            console.log("bad");
          } else {
            console.log("error");
          }
        });
    },

    doSignup() {
      axios({
        method: "POST",
        url: "/users",
        data: { username: this.username, password: this.password },
        headers: {
          "Content-Type": "application/json",
        },
      })
        .then((_) => {
          this.doLogin();
        })
        .catch((_) => {
          // TODO: flash
          return;
        });
    },
  },
};
</script>
