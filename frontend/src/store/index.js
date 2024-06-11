import axios from "axios";
import { useToast } from "vue-toast-notification";
import { createStore } from "vuex";

export default createStore({
  state: {
    authenticated: Boolean(localStorage.getItem("token")),
    successNotification: Boolean(JSON.parse(localStorage.getItem("successNotification"))),
    token: localStorage.getItem("token"),
    user: {},
    patients: undefined,
    doctors: undefined,
    medicalRecord: undefined,
    medicalRecords: undefined
  },
  mutations:{
    SET_AUTHENTICATED (state, value) {
        state.authenticated = value
    },
    SET_USER (state, value) {
        state.user = value
    },
    SET_TOKEN (state, value) {
      state.token = value
    },
    SET_SUCCESS_NOTIFICATION (state, value) {
      state.successNotification = value
    },
    SET_PATIENTS (state, value) {
      state.patients = value
    },
    SET_DOCTORS (state, value) {
      state.doctors = value
    },
    SET_MEDICAL_RECORD (state, value) {
      state.medicalRecord = value
    },
    SET_MEDICAL_RECORDS (state, value) {
      state.medicalRecords = value
    }
},
actions:{
  async register({commit}, payload){
    try {
      await axios.get("sanctum/csrf-cookie");
      const response = await axios.post("api/register", payload.values);
      localStorage.setItem("successNotification", true);
      commit('SET_SUCCESS_NOTIFICATION',true)
    } catch (error) {
      commit('SET_SUCCESS_NOTIFICATION',false)
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
      return error;
    }
  },
  async login({commit}, payload){
    try {
      await axios.get("sanctum/csrf-cookie");
      const response = await axios.post("api/login", payload.values);
      const user = await axios.get("api/user");
      localStorage.setItem("token", response.data.token);
      commit('SET_USER',user)
      commit('SET_AUTHENTICATED',true)
      commit('SET_TOKEN',response.data.token)
    } catch (error) {
      commit('SET_USER',{})
      commit('SET_AUTHENTICATED',false)
      const $toast = useToast();
      console.log(error);
      $toast.error(error.response.data.error, {
        type: "error",
        position: "top-right",
      });
      return error;
    }
  },
  async logout({commit}){
    try {
      await axios.post("api/logout");
      localStorage.removeItem("token");
      commit('SET_USER',{})
      commit('SET_AUTHENTICATED',false)
      commit('SET_TOKEN','')
    } catch (error) {
      console.log(error);
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
      return error;
    }
  },
  async getUser({commit}){
    try {
      await axios.get("sanctum/csrf-cookie");
      const user = await axios.get("api/user");
      commit('SET_USER',user.data)
      commit('SET_AUTHENTICATED',true)
    } catch (error) {
      console.log(error);
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
    }
  },
  async getAllMedicalRecords({commit}){
    try {
      await axios.get("sanctum/csrf-cookie");
      const medicalRecords = await axios.get("api/admin-records");
      commit('SET_MEDICAL_RECORDS',medicalRecords.data)
    } catch (error) {
      console.log(error);
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
    }
  },
  async getMedicalRecordsOfDoctor({commit}){
    try {
      await axios.get("sanctum/csrf-cookie");
      const medicalRecords = await axios.get("api/doctor-records");
      commit('SET_MEDICAL_RECORDS',medicalRecords.data)
    } catch (error) {
      console.log(error);
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
    }
  },
  async getMedicalRecordsOfPatient({commit}){
    try {
      await axios.get("sanctum/csrf-cookie");
      const medicalRecords = await axios.get("api/patient-records");
      commit('SET_MEDICAL_RECORDS',medicalRecords.data)
    } catch (error) {
      console.log(error);
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
    }
  },
  async getPatients({commit}){
    try {
      await axios.get("sanctum/csrf-cookie");
      const patients = await axios.get("api/patients");
      commit('SET_PATIENTS',patients.data)
    } catch (error) {
      console.log(error);
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
    }
  },
  async getDoctors({commit}){
    try {
      await axios.get("sanctum/csrf-cookie");
      const doctors = await axios.get("api/doctors");
      commit('SET_DOCTORS',doctors.data)
    } catch (error) {
      console.log(error);
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
    }
  },
  async addRecord({commit}, payload){
    try {
      await axios.get("sanctum/csrf-cookie");
      const response = await axios.post("api/records", payload.values);
    } catch (error) {
      commit('SET_SUCCESS_NOTIFICATION',false)
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
      return error;
    }
  },
  async editRecord({commit}, payload){
    try {
      await axios.get("sanctum/csrf-cookie");
      const response = await axios.put(`api/records/${payload.values.id}`, payload.values);
    } catch (error) {
      commit('SET_SUCCESS_NOTIFICATION',false)
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
      return error;
    }
  },
  async getRecord({commit}, payload){
    try {
      await axios.get("sanctum/csrf-cookie");
      const medicalRecord = await axios.get(`api/records/${payload.values.id}`, payload.values);
      commit('SET_MEDICAL_RECORD',medicalRecord.data)
      return true;
    } catch (error) {
      commit('SET_MEDICAL_RECORD',null)
      commit('SET_SUCCESS_NOTIFICATION',false)
      return false;
    }
  },
  async deleteRecord({commit}, payload){
    try {
      await axios.get("sanctum/csrf-cookie");
      const response = await axios.delete(`api/records/${payload.values.recordId}`, payload.values);
    } catch (error) {
      commit('SET_SUCCESS_NOTIFICATION',false)
      const $toast = useToast();
      $toast.error(error.response.data.message, {
        type: "error",
        position: "top-right",
      });
      return error;
    }
  },
},
  getters:{
    authenticated(state){
        return state.authenticated
    },
    user(state){
        return state.user
    },
    successNotification(state){
      return state.successNotification
    },
    token(state){
      return state.token
    },
    patients(state){
      return state.patients
    },
    doctors(state){
      return state.doctors
    },
    medicalRecords(state){
      return state.medicalRecords
    },
    medicalRecord(state){
      return state.medicalRecord
    },
},
});
