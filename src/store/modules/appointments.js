import axios from 'axios'

const state = {
  appointments: [],
}

const getters = {
  allAppointments: (state) => state.appointments,
}

const actions = {
  async fetchAppointments({ commit }) {
    const response = await axios.get('/api/appointments')
    commit('setAppointments', response.data)
  },
  async bookAppointment({ dispatch }, appointmentData) {
    await axios.post('/api/appointments', appointmentData)
    dispatch('fetchAppointments')
  },
  async updateAppointment({ dispatch }, appointmentData) {
    await axios.put(`/api/appointments/${appointmentData.id}`, appointmentData)
    dispatch('fetchAppointments')
  },
  async cancelAppointment({ dispatch }, appointmentId) {
    await axios.delete(`/api/appointments/${appointmentId}`)
    dispatch('fetchAppointments')
  },
}

const mutations = {
  setAppointments: (state, appointments) => (state.appointments = appointments),
}

export default {
  state,
  getters,
  actions,
  mutations,
}
