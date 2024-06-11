<script setup>
import store from "@/store";
import { Field, Form, ErrorMessage } from "vee-validate";
import { onBeforeMount, ref } from "vue";
import {
  Dialog,
  DialogPanel,
  TransitionChild,
  TransitionRoot,
} from "@headlessui/vue";
import { FolderIcon, XMarkIcon } from "@heroicons/vue/24/outline";
import { Bars3Icon } from "@heroicons/vue/20/solid";
import { useRoute, useRouter } from "vue-router";
import * as yup from "yup";

const route = useRoute();
const router = useRouter();

const user = ref(null);
const patients = ref(null);
const doctors = ref(null);

onBeforeMount(async () => {
  await store.dispatch("getUser");
  await store.dispatch("getPatients");
  await store.dispatch("getDoctors");

  user.value = store.getters.user;
  patients.value = store.getters.patients;
  doctors.value = store.getters.doctors;

  console.log(patients.value);
  console.log(doctors.value);
  // TBD
  // if (!store.state.authenticated || !localStorage.getItem("token")) {
  //   router.push({ name: "login" });
  // }
});

const schema = yup.object({
  patient_id: yup.number().required("Patient is required"),
  doctor_id: yup.number().required("Doctor is required"),
  illness: yup.string().required("Illnes is required"),
  diagnosis: yup.string().required("Diagnosis is required"),
  treatment: yup.string().required("Treatment is required"),
  remarks: yup.string().required("Remarks is required"),
});

const onLogout = async () => {
  store.dispatch("logout");
  router.push({ name: "login" });
};

const onSubmit = async (values) => {
  const response = await store.dispatch("addRecord", {
    key: "USER_VALUES",
    values,
  });

  if (!response) {
    router.push({ name: "dashboard-records" });
  }
};

const adminNavigation = [
  {
    name: "Patient's Records",
    href: "/dashboard/records",
    icon: FolderIcon,
    current: route.name === "dashboard-records",
  },
];

const doctorNavigation = [
  {
    name: "Patient's Records",
    href: "#",
    icon: FolderIcon,
    current: route.name === "dashboard-records",
  },
];

const patientNavigation = [
  {
    name: "My Records",
    href: "#",
    icon: FolderIcon,
    current: route.name === "dashboard-records",
  },
];

const activityItems = [
  // {
  //   user: {
  //     name: "Michael Foster",
  //     imageUrl:
  //       "https://images.unsplash.com/photo-1519244703995-f4e0f30006d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
  //   },
  //   commit: "2d89f0c8",
  //   branch: "main",
  //   status: "Completed",
  //   duration: "25s",
  //   date: "45 minutes ago",
  //   dateTime: "2023-01-23T11:00",
  // },
  // More items...
];

const sidebarOpen = ref(false);
</script>

<template>
  <div>
    <TransitionRoot as="template" :show="sidebarOpen">
      <Dialog
        as="div"
        class="relative z-50 xl:hidden"
        @close="sidebarOpen = false"
      >
        <TransitionChild
          as="template"
          enter="transition-opacity ease-linear duration-300"
          enter-from="opacity-0"
          enter-to="opacity-100"
          leave="transition-opacity ease-linear duration-300"
          leave-from="opacity-100"
          leave-to="opacity-0"
        >
          <div class="fixed inset-0 bg-gray-900/80" />
        </TransitionChild>

        <div class="fixed inset-0 flex">
          <TransitionChild
            as="template"
            enter="transition ease-in-out duration-300 transform"
            enter-from="-translate-x-full"
            enter-to="translate-x-0"
            leave="transition ease-in-out duration-300 transform"
            leave-from="translate-x-0"
            leave-to="-translate-x-full"
          >
            <DialogPanel class="relative mr-16 flex w-full max-w-xs flex-1">
              <TransitionChild
                as="template"
                enter="ease-in-out duration-300"
                enter-from="opacity-0"
                enter-to="opacity-100"
                leave="ease-in-out duration-300"
                leave-from="opacity-100"
                leave-to="opacity-0"
              >
                <div
                  class="absolute left-full top-0 flex w-16 justify-center pt-5"
                >
                  <button
                    type="button"
                    class="-m-2.5 p-2.5"
                    @click="sidebarOpen = false"
                  >
                    <span class="sr-only">Close sidebar</span>
                    <XMarkIcon class="h-6 w-6 text-white" aria-hidden="true" />
                  </button>
                </div>
              </TransitionChild>
              <div
                class="flex grow flex-col gap-y-5 overflow-y-auto bg-white px-6 ring-1 ring-white/10"
              >
                <div class="flex h-16 shrink-0 items-center">
                  <h1 class="font-bold">Hospital Management System</h1>
                </div>
                <nav class="flex flex-1 flex-col">
                  <ul role="list" class="flex flex-1 flex-col gap-y-7">
                    <li>
                      <ul
                        v-if="user?.admin"
                        role="list"
                        class="-mx-2 space-y-1"
                      >
                        <li v-for="item in adminNavigation" :key="item.name">
                          <a
                            :href="item.href"
                            :class="[
                              item.current
                                ? 'bg-gray-300'
                                : 'text-gray-900 hover:bg-gray-300',
                              'group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold',
                            ]"
                          >
                            <component
                              :is="item.icon"
                              class="h-6 w-6 shrink-0"
                              aria-hidden="true"
                            />
                            {{ item.name }}
                          </a>
                        </li>
                      </ul>
                      <ul
                        v-if="user?.doctor"
                        role="list"
                        class="-mx-2 space-y-1"
                      >
                        <li v-for="item in doctorNavigation" :key="item.name">
                          <a
                            :href="item.href"
                            :class="[
                              item.current
                                ? 'bg-gray-300'
                                : 'text-gray-900 hover:bg-gray-300',
                              'group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold',
                            ]"
                          >
                            <component
                              :is="item.icon"
                              class="h-6 w-6 shrink-0"
                              aria-hidden="true"
                            />
                            {{ item.name }}
                          </a>
                        </li>
                      </ul>
                      <ul
                        v-if="user?.patient"
                        role="list"
                        class="-mx-2 space-y-1"
                      >
                        <li v-for="item in patientNavigation" :key="item.name">
                          <a
                            :href="item.href"
                            :class="[
                              item.current
                                ? 'bg-gray-300'
                                : 'text-gray-900 hover:bg-gray-300',
                              'group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold',
                            ]"
                          >
                            <component
                              :is="item.icon"
                              class="h-6 w-6 shrink-0"
                              aria-hidden="true"
                            />
                            {{ item.name }}
                          </a>
                        </li>
                      </ul>
                    </li>

                    <li class="-mx-6 mt-auto">
                      <button
                        type="button"
                        @click="onLogout"
                        class="w-full flex items-center justify-center px-6 py-3 text-sm font-semibold leading-6 text-red-600 hover:text-red-500 hover:bg-gray-300"
                      >
                        Logout
                      </button>
                    </li>
                  </ul>
                </nav>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </Dialog>
    </TransitionRoot>

    <div
      class="hidden xl:fixed xl:inset-y-0 xl:z-50 xl:flex xl:w-72 xl:flex-col"
    >
      <div
        class="flex grow flex-col gap-y-5 overflow-y-auto bg-white px-6 ring-1 ring-white/5"
      >
        <div class="flex h-16 shrink-0 items-center">
          <h1 class="font-bold">Hospital Management System</h1>
        </div>
        <nav class="flex flex-1 flex-col">
          <ul role="list" class="flex flex-1 flex-col gap-y-7">
            <li>
              <ul v-if="user?.admin" role="list" class="-mx-2 space-y-1">
                <li v-for="item in adminNavigation" :key="item.name">
                  <a
                    :href="item.href"
                    :class="[
                      item.current
                        ? 'bg-gray-300'
                        : 'text-gray-900 hover:bg-gray-300',
                      'group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold',
                    ]"
                  >
                    <component
                      :is="item.icon"
                      class="h-6 w-6 shrink-0"
                      aria-hidden="true"
                    />
                    {{ item.name }}
                  </a>
                </li>
              </ul>
              <ul v-if="user?.doctor" role="list" class="-mx-2 space-y-1">
                <li v-for="item in doctorNavigation" :key="item.name">
                  <a
                    :href="item.href"
                    :class="[
                      item.current
                        ? 'bg-gray-300'
                        : 'text-gray-900 hover:bg-gray-300',
                      'group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold',
                    ]"
                  >
                    <component
                      :is="item.icon"
                      class="h-6 w-6 shrink-0"
                      aria-hidden="true"
                    />
                    {{ item.name }}
                  </a>
                </li>
              </ul>
              <ul v-if="user?.patient" role="list" class="-mx-2 space-y-1">
                <li v-for="item in patientNavigation" :key="item.name">
                  <a
                    :href="item.href"
                    :class="[
                      item.current
                        ? 'bg-gray-300'
                        : 'text-gray-900 hover:bg-gray-300',
                      'group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold',
                    ]"
                  >
                    <component
                      :is="item.icon"
                      class="h-6 w-6 shrink-0"
                      aria-hidden="true"
                    />
                    {{ item.name }}
                  </a>
                </li>
              </ul>
            </li>
            <li class="-mx-6 mt-auto">
              <button
                type="button"
                @click="onLogout"
                class="w-full flex items-center justify-center px-6 py-3 text-sm font-semibold leading-6 text-red-600 hover:text-red-500 hover:bg-gray-300"
              >
                Logout
              </button>
            </li>
          </ul>
        </nav>
      </div>
    </div>

    <div class="xl:pl-72">
      <div
        class="sticky top-0 z-40 flex xl:hidden h-16 shrink-0 items-center gap-x-6 border-b border-white/5 bg-white px-4 shadow-sm sm:px-6 lg:px-8"
      >
        <button
          type="button"
          class="-m-2.5 p-2.5 text-gray-800 xl:hidden"
          @click="sidebarOpen = true"
        >
          <span class="sr-only">Open sidebar</span>
          <Bars3Icon class="h-5 w-5" aria-hidden="true" />
        </button>
      </div>

      <main>
        <div class="border-t border-gray/50 pt-12">
          <div class="flex justify-between">
            <h2
              class="px-4 text-base font-semibold leading-7 text-gray-800 sm:px-6 lg:px-8"
            >
              Add Patient's Records
            </h2>
          </div>
          <Form class="p-8" @submit="onSubmit" :validation-schema="schema">
            <div class="space-y-12">
              <div class="border-b border-gray-900/10 pb-12">
                <div class="grid grid-cols-1 gap-x-6 gap-y-16 sm:grid-cols-6">
                  <div class="sm:col-span-3">
                    <label
                      for="patient_id"
                      class="block text-sm font-medium leading-6 text-gray-900"
                      >Patient</label
                    >
                    <div class="mt-2">
                      <Field
                        as="select"
                        id="patient_id"
                        name="patient_id"
                        class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:max-w-xs sm:text-sm sm:leading-6"
                      >
                        <option value="" selected disabled hidden>
                          Please select a patient
                        </option>
                        <option
                          v-for="patient in patients"
                          :key="patient.id"
                          :value="patient.id"
                        >
                          {{ patient.first_name }} {{ patient.last_name }}
                        </option>
                      </Field>
                    </div>
                    <ErrorMessage
                      name="patient_id"
                      class="text-red-500 text-sm"
                    />
                  </div>

                  <div class="sm:col-span-3">
                    <label
                      for="doctor_id"
                      class="block text-sm font-medium leading-6 text-gray-900"
                      >Doctor</label
                    >
                    <div class="mt-2">
                      <Field
                        as="select"
                        id="doctor_id"
                        name="doctor_id"
                        class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:max-w-xs sm:text-sm sm:leading-6"
                      >
                        <option value="" selected disabled hidden>
                          Please select a doctor
                        </option>
                        <option
                          v-for="doctor in doctors"
                          :key="doctor.id"
                          :value="doctor.id"
                        >
                          {{ doctor.first_name }} {{ doctor.last_name }}
                        </option>
                      </Field>
                    </div>
                    <ErrorMessage
                      name="doctor_id"
                      class="text-red-500 text-sm"
                    />
                  </div>

                  <div class="sm:col-span-3">
                    <label
                      for="illness"
                      class="block text-sm font-medium leading-6 text-gray-900"
                      >Illness</label
                    >
                    <div class="mt-2">
                      <Field
                        id="illness"
                        name="illness"
                        type="text"
                        class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                      />
                    </div>
                    <ErrorMessage name="illness" class="text-red-500 text-sm" />
                  </div>

                  <div class="sm:col-span-3">
                    <label
                      for="diagnosis"
                      class="block text-sm font-medium leading-6 text-gray-900"
                      >Diagnosis</label
                    >
                    <div class="mt-2">
                      <Field
                        id="diagnosis"
                        name="diagnosis"
                        type="text"
                        class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                      />
                    </div>
                    <ErrorMessage
                      name="diagnosis"
                      class="text-red-500 text-sm"
                    />
                  </div>

                  <div class="sm:col-span-3">
                    <label
                      for="treatment"
                      class="block text-sm font-medium leading-6 text-gray-900"
                      >Treatment</label
                    >
                    <div class="mt-2">
                      <Field
                        id="treatment"
                        name="treatment"
                        type="text"
                        class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                      />
                    </div>
                    <ErrorMessage
                      name="treatment"
                      class="text-red-500 text-sm"
                    />
                  </div>

                  <div class="sm:col-span-3">
                    <label
                      for="remarks"
                      class="block text-sm font-medium leading-6 text-gray-900"
                      >Remarks</label
                    >
                    <div class="mt-2">
                      <Field
                        id="remarks"
                        name="remarks"
                        type="text"
                        class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                      />
                    </div>
                    <ErrorMessage name="remarks" class="text-red-500 text-sm" />
                  </div>
                </div>
              </div>
            </div>

            <div class="mt-6 flex items-center justify-end gap-x-6">
              <button
                type="button"
                class="text-sm font-semibold leading-6 text-gray-900"
              >
                Cancel
              </button>
              <button
                type="submit"
                class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
              >
                Save
              </button>
            </div>
          </Form>
        </div>
      </main>
    </div>
  </div>
</template>
