<template>
  <router-view />
</template>
<script>
export default {
  name: "App",
  data() {
    return {
      apiUrl: "http://127.0.0.1:8000/api",
    };
  },
};
</script>

<style>
/* Define global variables */
:root {
  --global-color-primary: #f53d74;
  --global-color-secondary: #2da5dd;
  --font-family: 'Arial, sans-serif';
}

/* Apply global styles */
body {
  font-family: var(--font-family);
  background-color: #f5f5f5;
  margin: 0;
  padding: 0;
}

#app {
  text-align: center;
}

/* Style the sidebar */
.sidebar {
  background-color: var(--primary-color);
  color: white;
  padding: 20px;
  height: 100vh;
  width: 250px;
  position: fixed;
}

.sidebar a {
  color: white;
  text-decoration: none;
  display: block;
  padding: 10px 0;
}

.sidebar a:hover {
  background-color: var(--secondary-color);
}

/* Style the main content */
.main-content {
  margin-left: 250px;
  padding: 20px;
}

.button {
  background-color: var(--primary-color);
  color: white;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
  border-radius: 5px;
}

.button:hover {
  background-color: var(--secondary-color);
}
</style>
