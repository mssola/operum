import { defineStore } from "pinia";

// Define the `token` store, which stores the API token to be used across calls.
export const tokenStore = defineStore("token", {
  state: () => ({
    token: "",
  }),
  persist: true,
});
