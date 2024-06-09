<template>
    <div>
      <vue-cal
        :events="events"
        @cell-click="handleCellClick"
      />
      <div v-if="selectedAppointment">
        <h3>Appointment Details</h3>
        <p>Patient: {{ selectedAppointment.patient.name }}</p>
        <p>Doctor: {{ selectedAppointment.doctor.name }}</p>
        <p>Date: {{ selectedAppointment.appointment_date }}</p>
        <p>Status: {{ selectedAppointment.status }}</p>
      </div>
    </div>
  </template>
  
  <script>
  import VueCal from 'vue-cal'
  import 'vue-cal/dist/vuecal.css'
  import axios from 'axios'
  
  export default {
    components: { VueCal },
    data() {
      return {
        events: [],
        selectedAppointment: null,
      }
    },
    created() {
      this.fetchAppointments()
    },
    methods: {
      fetchAppointments() {
        axios.get('/api/appointments').then(response => {
          this.events = response.data.map(appointment => ({
            start: new Date(appointment.appointment_date),
            end: new Date(appointment.appointment_date),
            title: `${appointment.patient.name} with Dr. ${appointment.doctor.name}`,
            data: appointment,
          }))
        })
      },
      handleCellClick(event) {
        this.selectedAppointment = event.data
      },
    },
  }
  </script>
  