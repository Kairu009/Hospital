import Vue from 'vue'
import VueRouter from 'vue-router'
import Calendar from '../components/Calendar.vue'
import BookAppointment from '../components/BookAppointment.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/appointments',
    name: 'Calendar',
    component: Calendar
  },
  {
    path: '/book-appointment',
    name: 'BookAppointment',
    component: BookAppointment
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
