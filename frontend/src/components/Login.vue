<script setup>
import store from "@/store";
import { Field, Form, ErrorMessage } from "vee-validate";
import { onBeforeMount } from "vue";
import { useRouter } from "vue-router";
import { useToast } from "vue-toast-notification";
import * as yup from "yup";

const router = useRouter();

onBeforeMount(() => {
  // TBD
  // if (store.state.authenticated && localStorage.getItem("token")) {
  //   router.push({ name: "dashboard" });
  // }

  if (store.state.successNotification) {
    const $toast = useToast();
    $toast.success("Registered Successfully!", {
      type: "success",
      position: "top-right",
    });
    localStorage.setItem("successNotification", false);
  }
});

const schema = yup.object({
  email: yup
    .string()
    .email("Email must be valid")
    .required("Email is required"),
  password: yup
    .string()

    .required("Password is required"),
});

const onSubmit = async (values) => {
  const response = await store.dispatch("login", {
    key: "USER_VALUES",
    values,
  });
  if (!response) {
    router.push({ name: "dashboard-records" });
  }
};
</script>

<template>
  <div
    class="flex min-h-full flex-1 flex-col justify-center py-12 sm:px-6 lg:px-8"
  >
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <h2
        class="mt-6 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900"
      >
        Sign in to your account
      </h2>
    </div>

    <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-[480px]">
      <div class="bg-white px-6 py-12 shadow sm:rounded-lg sm:px-12">
        <Form class="space-y-6" @submit="onSubmit" :validation-schema="schema">
          <div>
            <label
              for="email"
              class="block text-sm font-medium leading-6 text-gray-900"
              >Email address</label
            >
            <div class="mt-2">
              <Field
                id="email"
                name="email"
                type="email"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-gray-600 sm:text-sm sm:leading-6"
              />
            </div>
            <ErrorMessage name="email" class="text-red-500 text-sm" />
          </div>

          <div>
            <label
              for="password"
              class="block text-sm font-medium leading-6 text-gray-900"
              >Password</label
            >
            <div class="mt-2">
              <Field
                id="password"
                name="password"
                type="password"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
            <ErrorMessage name="password" class="text-red-500 text-sm" />
          </div>

          <div>
            <button
              type="submit"
              class="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
            >
              Sign in
            </button>
          </div>
        </Form>

        <div>
          <div class="relative mt-10">
            <div class="absolute inset-0 flex items-center" aria-hidden="true">
              <div class="w-full border-t border-gray-200" />
            </div>
            <div
              class="relative flex justify-center text-sm font-medium leading-6"
            >
              <span class="bg-white px-6 text-gray-900"
                >Don't have an account yet?</span
              >
            </div>
          </div>

          <div class="mt-6">
            <RouterLink to="/register">
              <button
                type="submit"
                class="flex w-full justify-center rounded-md bg-gray-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-gray-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-gray-600"
              >
                Register
              </button>
            </RouterLink>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
