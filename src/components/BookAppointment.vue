<template>
    <div>
      <h3>Book an Appointment</h3>
      <form @submit.prevent="bookAppointment">
        <label for="doctor">Doctor:</label>
        <select v-model="form.doctor_id">
          <option v-for="doctor in doctors" :value="doctor.id" :key="doctor.id">
            Dr. {{ doctor.name }}
          </option>
        </select>
  
        <label for="date">Date:</label>
        <input type="datetime-local" v-model="form.appointment_date" />
  
        <button type="submit">Book</button>
      </form>
    </div>
  </template>
  
  <script>
  import axios from 'axios'
  
  export default {
    data() {
      return {
        form: {
          doctor_id: '',
          appointment_date: '',
        },
        doctors: [],
      }
    },
    created() {
      this.fetchDoctors()
    },
    methods: {
      fetchDoctors() {
        axios.get('/api/doctors').then(response => {
          this.doctors = response.data
        })
      },
      bookAppointment() {
        axios.post('/api/appointments', {
          patient_id: this.$store.state.user.id,
          doctor_id: this.form.doctor_id,
          appointment_date: this.form.appointment_date,
        }).then(() => {
          alert('Appointment booked successfully')
          this.$router.push('/appointments')
        })
      },
    },
  }
  </script>
  