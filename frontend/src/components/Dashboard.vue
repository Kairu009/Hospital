<script setup>
import store from "@/store";
import { onBeforeMount, ref, watch } from "vue";
import {
  Dialog,
  DialogPanel,
  TransitionChild,
  TransitionRoot,
} from "@headlessui/vue";
import { FolderIcon, XMarkIcon } from "@heroicons/vue/24/outline";
import { Bars3Icon } from "@heroicons/vue/20/solid";
import { useRoute, useRouter } from "vue-router";

const route = useRoute();
const router = useRouter();

const user = ref(null);
const medicalRecords = ref(null);

onBeforeMount(async () => {
  await store.dispatch("getUser");

  user.value = store.getters.user;

  if (user.value && user.value.admin) {
    await store.dispatch("getAllMedicalRecords");
    medicalRecords.value = store.getters.medicalRecords;
  }

  if (user.value && user.value.doctor) {
    await store.dispatch("getMedicalRecordsOfDoctor");
    medicalRecords.value = store.getters.medicalRecords;
  }

  if (user.value && user.value.patient) {
    await store.dispatch("getMedicalRecordsOfPatient");
    medicalRecords.value = store.getters.medicalRecords;
  }

  // TBD
  // if (!store.state.authenticated || !localStorage.getItem("token")) {
  //   router.push({ name: "login" });
  // }
});

const onEdit = async (id) => {
  router.push({ name: "dashboard-records-edit", params: { id } });
};

const onDelete = async (recordId) => {
  const response = await store.dispatch("deleteRecord", {
    key: "USER_VALUES",
    values: { recordId },
  });
  location.reload();
  if (!response) {
    router.push({ name: "dashboard-records" });
  }
};

const onLogout = async () => {
  store.dispatch("logout");
  router.push({ name: "login" });
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

const addNewRecord = () => {
  router.push({ name: "dashboard-records-add" });
};

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
              v-if="user?.admin || user?.doctor"
              class="px-4 text-base font-semibold leading-7 text-gray-800 sm:px-6 lg:px-8"
            >
              Patient's Records
            </h2>
            <h2
              v-if="user?.patient"
              class="px-4 text-base font-semibold leading-7 text-gray-800 sm:px-6 lg:px-8"
            >
              My Records
            </h2>
            <button
              v-if="user?.admin"
              @click="addNewRecord"
              class="mx-4 flex justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
            >
              Add new record
            </button>
          </div>
          <table class="mt-6 w-full whitespace-nowrap text-left">
            <colgroup>
              <col class="w-full sm:w-4/12" />
              <col class="lg:w-4/12" />
              <col class="lg:w-2/12" />
              <col class="lg:w-1/12" />
              <col class="lg:w-1/12" />
            </colgroup>
            <thead
              class="border-b border-gray/50 text-sm leading-6 text-gray-800"
            >
              <tr>
                <th
                  scope="col"
                  class="py-2 pl-4 pr-8 font-semibold sm:pl-6 lg:pl-8"
                >
                  Patient's Name
                </th>
                <th
                  scope="col"
                  class="hidden py-2 pl-0 pr-8 font-semibold sm:table-cell"
                >
                  Doctor's Name
                </th>
                <th
                  scope="col"
                  class="py-2 pl-0 pr-4 text-right font-semibold sm:pr-8 sm:text-left lg:pr-20"
                >
                  Illness
                </th>
                <th
                  scope="col"
                  class="hidden py-2 pl-0 pr-8 font-semibold md:table-cell lg:pr-20"
                >
                  Diagnosis
                </th>
                <th
                  scope="col"
                  class="hidden py-2 pl-0 pr-8 font-semibold md:table-cell lg:pr-20"
                >
                  Treatment
                </th>
                <th
                  scope="col"
                  class="hidden py-2 pl-0 pr-8 font-semibold md:table-cell lg:pr-20"
                >
                  Remarks
                </th>
                <th
                  v-if="user?.admin || user?.doctor"
                  scope="col"
                  class="hidden py-2 pl-0 pr-4 font-semibold sm:table-cell sm:pr-6 lg:pr-8"
                >
                  Actions
                </th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray/50">
              <tr v-if="medicalRecords?.length === 0">
                <td
                  colspan="6"
                  class="py-4 pl-4 pr-8 sm:pl-6 lg:pl-8 text-center"
                >
                  No records found
                </td>
              </tr>
              <tr v-for="item in medicalRecords" :key="item.id">
                <td class="py-4 pl-4 pr-8 sm:pl-6 lg:pl-8">
                  <div class="flex items-center gap-x-4">
                    <div class="truncate text-sm leading-6 text-gray-800">
                      {{ item.patient.first_name }} {{ item.patient.last_name }}
                    </div>
                  </div>
                </td>
                <td class="py-4 pl-0 pr-4 text-sm leading-6 sm:pr-8 lg:pr-20">
                  <div
                    class="flex items-center justify-end gap-x-2 sm:justify-start"
                  >
                    <div class="hidden text-gray-800 sm:block">
                      {{ item.doctor.first_name }} {{ item.doctor.last_name }}
                    </div>
                  </div>
                </td>
                <td class="py-4 pl-0 pr-4 text-sm leading-6 sm:pr-8 lg:pr-20">
                  <div
                    class="flex items-center justify-end gap-x-2 sm:justify-start"
                  >
                    <div class="hidden text-gray-800 sm:block">
                      {{ item.illness }}
                    </div>
                  </div>
                </td>
                <td class="py-4 pl-0 pr-4 text-sm leading-6 sm:pr-8 lg:pr-20">
                  <div
                    class="flex items-center justify-end gap-x-2 sm:justify-start"
                  >
                    <div class="hidden text-gray-800 sm:block">
                      {{ item.diagnosis }}
                    </div>
                  </div>
                </td>
                <td class="py-4 pl-0 pr-4 text-sm leading-6 sm:pr-8 lg:pr-20">
                  <div
                    class="flex items-center justify-end gap-x-2 sm:justify-start"
                  >
                    <div class="hidden text-gray-800 sm:block">
                      {{ item.treatment }}
                    </div>
                  </div>
                </td>
                <td class="py-4 pl-0 pr-4 text-sm leading-6 sm:pr-8 lg:pr-20">
                  <div
                    class="flex items-center justify-end gap-x-2 sm:justify-start"
                  >
                    <div class="truncate hidden text-gray-800 sm:block">
                      {{ item.remarks }}
                    </div>
                  </div>
                </td>
                <td
                  v-if="user?.admin || user?.doctor"
                  class="hidden space-x-4 py-4 pl-0 pr-4 text-sm leading-6 text-gray-400 sm:table-cell sm:pr-6 lg:pr-8"
                >
                  <button @click="onEdit(item.id)" class="text-blue-500">
                    Edit
                  </button>
                  <button
                    v-if="user?.admin"
                    @click="onDelete(item.id)"
                    class="text-red-500"
                  >
                    Delete
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </main>
    </div>
  </div>
</template>
