import Vue from 'vue';
import Router from 'vue-router';
import Calendar from './components/Calendar.vue';
import BookAppointment from './components/BookAppointment.vue';

Vue.use(Router);

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/appointments',
            name: 'Calendar',
            component: Calendar,
        },
        {
            path: '/book-appointment',
            name: 'BookAppointment',
            component: BookAppointment,
        },
    ],
});
