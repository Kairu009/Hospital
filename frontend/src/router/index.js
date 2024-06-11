import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      redirect: to => {
        // the function receives the target route as the argument
        // we return a redirect path/location here.
        return { path: '/login' }
      },
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/LoginView.vue"),
    },
    {
      path: "/register",
      name: "register",
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import("../views/RegisterView.vue"),
    },
    {
      path: "/dashboard",
      redirect: to => {
        // the function receives the target route as the argument
        // we return a redirect path/location here.
        return { path: '/dashboard/records' }
      },
    },
    {
      path: "/dashboard/records",
      name: "dashboard-records",
      component: () => import("../views/DashboardView.vue"),
    },
    {
      path: "/dashboard/records/add",
      name: "dashboard-records-add",
      component: () => import("../views/DashboardAddView.vue"),
    },
    {
      path: "/dashboard/records/edit",
      redirect: to => {
        // the function receives the target route as the argument
        // we return a redirect path/location here.
        return { path: '/dashboard/records' }
      },
    },
    {
      path: "/dashboard/records/edit/:id",
      name: "dashboard-records-edit",
      component: () => import("../views/DashboardEditView.vue"),
    },
  ],
});

export default router;
