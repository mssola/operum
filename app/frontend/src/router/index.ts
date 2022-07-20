import { createRouter, createWebHistory } from "vue-router";
import Books from "../views/Books.vue";
import Login from "../views/Login.vue";
import User from "../views/User.vue";

const routes = [
  {
    path: "/",
    name: "Books",
    component: Books,
  },
  {
    path: "/user",
    name: "User",
    component: User,
  },
  {
    path: "/login",
    name: "Login",
    component: Login,
  },
];

// TODO
const isAuthenticated = () => {
  return false;
};

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

router.beforeEach((to, from, next) => {
  if (to.name === "User") next();
  else if (to.name !== "Login" && !isAuthenticated()) next({ name: "Login" });
  else next();
});

export default router;
