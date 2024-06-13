<template>
  <section id="login">
    <div class="wrapper">
      <div class="login-container">
        <div class="login-details">
          <h1>Hospital <span>Management</span> System</h1>
          <i
            ><p>
              Join healthcare <span> professionals </span> on this platform.
            </p></i
          >
        </div>
        <form @submit.prevent="loginUser">
          <div class="header-text mb-3">
            <h2>Welcome back!</h2>
            <p>We are happy to have you back.</p>
          </div>
          <div class="field-con">
            <input
              type="email"
              class="form-control"
              name="email"
              id="email"
              v-model="email"
              placeholder="Email"
              @input="clearErrors"
              required
            />
            <small class="text-danger" v-if="errors">{{ errors }}</small>
          </div>
          <div class="field-con">
            <input
              type="password"
              class="form-control"
              name="password"
              placeholder="Password"
              v-model="password"
              @input="clearErrors"
              required
            />
          </div>
          <div class="row">
            <small
              >Don't have an account?
              <a href="" @click.prevent="navigateToRegister">SignUp</a></small
            >
          </div>
          <div class="btn-con">
            <button type="submit" class="btn-primary">LOGIN</button>
          </div>
        </form>
      </div>
    </div>
  </section>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      email: "",
      password: "",
      errors: null,
    };
  },
  methods: {
    navigateToRegister() {
      this.$router.push({ path: "/register" });
    },
    async loginUser() {
      try {
        const response = await axios.post(this.$store.state.apiUrl + "/login", {
          email: this.email,
          password: this.password,
        });

        if (response.status === 200) {
          localStorage.setItem("user_id", response.data.user_id);
          localStorage.setItem("token", response.data.token);
          localStorage.setItem(
            "account_type",
            JSON.stringify(response.data.account_type)
          );
          this.$router.push("/dashboard");
        }
      } catch (error) {
        this.errors = error.response.data.message;
      }
    },
    clearErrors() {
      this.errors = null;
    },
  },
};
</script>

<style scoped>
.header-text h2 {
  font-size: 40 px;
  color: var(--global-color-secondary);
}

#login {
  height: 100vh;
  position: relative;
  margin: 0;
  padding: 0;
}

#login::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;

  background-position: center;
}

#login::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: var(--global-color-black);
  z-index: -1;
}

#login > * {
  position: relative;
  z-index: 1;
}

#login .wrapper {
  max-width: 1440px;
}

#login .login-container {
  display: flex;
  justify-content: center;
  gap: 100px;
  align-items: center;
}

#login .login-details {
  max-width: 500px;
  width: 100%;
}

#login .login-details h1,
#login .login-details p {
  color: var(--global-color-white);
}

#login .login-details h1 span {
  color: var(--global-color-secondary);
}

#login .login-details p span {
  color: var(--global-color-secondary);
}

#login .login-container form {
  max-width: 500px;
  width: 100%;
  padding: 20px;
  background: var(--global-color-white);
  box-shadow: var(--global-shadow);
  border-radius: 5px;
}

.btn-primary {
  border-radius: 50px;
  background-color: #6366f1; /* Primary violet color */
  transition: background 0.3s ease; /* Smooth transition for the hover effect */
}

.btn-primary:hover {
  background: linear-gradient(
    to right,
    #6366f1,
    /* Base violet color */ #4f46e5,
    /* Darker violet */ #7c3aed /* Another shade of violet */
  );
}

@media screen and (max-width: 767px) {
  #login .login-container {
    padding: 100px 0;
    text-align: center;
    gap: 50px;
    flex-direction: column;
  }
}

@media screen and (min-width: 768px) {
  #login .login-container {
    padding: 100px 0;
    text-align: center;
    gap: 50px;
    flex-direction: column;
  }
}

@media screen and (min-width: 1024px) {
  #login .login-container {
    flex-direction: row;
    padding: 200px 0;
    text-align: left;
  }
}
</style>
