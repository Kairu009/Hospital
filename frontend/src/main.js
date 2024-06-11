import "./assets/main.css";

import { createApp } from "vue";
import ToastPlugin from 'vue-toast-notification';
import App from "./App.vue";
import router from "./router";
import store from "./store";
import axios from "axios";
// Import one of the available themes
//import 'vue-toast-notification/dist/theme-default.css';
import 'vue-toast-notification/dist/theme-bootstrap.css';

axios.defaults.withCredentials = true;
axios.defaults.withXSRFToken = true;
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
axios.defaults.baseURL = "http://localhost:8000";

const app = createApp(App);

app.use(ToastPlugin);

app.use(store);

app.use(router);

app.mount("#app");
