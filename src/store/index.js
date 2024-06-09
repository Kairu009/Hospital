import Vue from 'vue'
import Vuex from 'vuex'
import appointments from './modules/appointments'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    appointments
  }
})
