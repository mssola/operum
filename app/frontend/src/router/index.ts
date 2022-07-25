import { createRouter, createWebHistory } from "vue-router";
import Books from "../views/Books.vue";
import Login from "../views/Login.vue";
import UserView from "../views/User.vue";
import axios from "axios";
import { tokenStore } from "../stores/token.ts";
import types from "../utils/types.ts";

const routes = [
  {
    path: "/",
    name: "Books",
    component: Books,
  },
  {
    path: "/user",
    name: "User",
    component: UserView,
  },
  {
    path: "/login",
    name: "Login",
    component: Login,
  },
];

// Returns true if the current user is authenticated, false otherwise.
const isAuthenticated = (): boolean => {
  // We are making the assumption that the token that we have on store is valid.
  // If that was not the case, then it's up to the calls to `axios` to respond
  // to a 403 response from the server.
  const token = tokenStore().token;
  return !types.isblank(token);
};

async function canAccessUser(): Promise<any> {
  return axios({
    method: "GET",
    url: "/users/can",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((resp) => {
      return resp.data.can;
    })
    .catch((_) => {
      return false;
    });
}

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

router.beforeEach((to, _from, next) => {
  if (to.name === "User") {
    canAccessUser().then((value) => {
      value ? next() : next({ name: "Books" });
    });
  } else if (to.name !== "Login" && !isAuthenticated()) {
    next({ name: "Login" });
  } else {
    next();
  }
});

export default router;
