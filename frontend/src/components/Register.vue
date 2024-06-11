<script setup>
import store from "@/store";
import { Field, Form, ErrorMessage } from "vee-validate";
import { useRouter } from "vue-router";
import * as yup from "yup";
import "vue-toast-notification/dist/theme-sugar.css";

const router = useRouter();

const schema = yup.object({
  first_name: yup.string().required("First Name is required"),
  last_name: yup.string().required("Last Name is required"),
  email: yup
    .string()
    .email("Email must be valid")
    .required("Email is required"),
  password: yup
    .string()
    .min(8, "Password must be at least 8 characters long")
    .required("Password is required"),
  confirm_password: yup
    .string()
    .oneOf([yup.ref("password"), null], "Passwords must match")
    .required("Confirm Password is required"),
  type: yup
    .string()
    .oneOf(
      ["Admin", "Doctor", "Patient"],
      "Invalid type. Must be one of: Admin, Doctor, Patient."
    )
    .required("Type is required"),
});

const onSubmit = async (values) => {
  const response = await store.dispatch("register", {
    key: "USER_VALUES",
    values,
  });
  if (!response) {
    router.push({ name: "login" });
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
        Create a new account
      </h2>
    </div>

    <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-[480px]">
      <div class="bg-white px-6 py-12 shadow sm:rounded-lg sm:px-12">
        <Form class="space-y-6" @submit="onSubmit" :validation-schema="schema">
          <div>
            <label
              for="first_name"
              class="block text-sm font-medium leading-6 text-gray-900"
              >First Name</label
            >
            <div class="mt-2">
              <Field
                id="first_name"
                name="first_name"
                type="text"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
            <ErrorMessage name="first_name" class="text-red-500 text-sm" />
          </div>

          <div>
            <label
              for="last_name"
              class="block text-sm font-medium leading-6 text-gray-900"
              >Last Name</label
            >
            <div class="mt-2">
              <Field
                id="last_name"
                name="last_name"
                type="text"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
            <ErrorMessage name="last_name" class="text-red-500 text-sm" />
          </div>

          <div>
            <label
              for="email"
              class="block text-sm font-medium leading-6 text-gray-900"
              >Email Address</label
            >
            <div class="mt-2">
              <Field
                id="email"
                name="email"
                type="email"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
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
            <label
              for="confirm_password"
              class="block text-sm font-medium leading-6 text-gray-900"
              >Confirm Password</label
            >
            <div class="mt-2">
              <Field
                id="confirm_password"
                name="confirm_password"
                type="password"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
            <ErrorMessage
              name="confirm_password"
              class="text-red-500 text-sm"
            />
          </div>

          <div>
            <label
              for="email"
              class="block text-sm font-medium leading-6 text-gray-900"
              >Type</label
            >
            <div class="mt-2">
              <Field
                as="select"
                id="type"
                name="type"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              >
                <option value="" selected disabled hidden>
                  Please select user type
                </option>
                <option value="Admin">Admin</option>
                <option value="Doctor">Doctor</option>
                <option value="Patient">Patient</option>
              </Field>
            </div>
            <ErrorMessage name="type" class="text-red-500 text-sm" />
          </div>

          <div>
            <button
              type="submit"
              class="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:bg-blue-300"
            >
              Create account
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
                >Already have an account?</span
              >
            </div>
          </div>

          <div class="mt-6">
            <RouterLink to="/login">
              <button
                type="submit"
                class="flex w-full justify-center rounded-md bg-gray-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-gray-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-gray-600"
              >
                Login
              </button>
            </RouterLink>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
