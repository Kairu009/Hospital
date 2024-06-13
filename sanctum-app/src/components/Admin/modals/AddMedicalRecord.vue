<template>
    <div v-if="openClose" class="modal fade show" tabindex="-1" aria-hidden="true" id="addMedicalRecord" style="display: block">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-body">
            <h4>Add Medical Record</h4>
            <form @submit.prevent="submitForm">
              <div class="form-group">
                <label for="weight">Weight</label>
                <input type="number" v-model="form.weight" class="form-control" id="weight" required>
              </div>
              <div class="form-group">
                <label for="height">Height</label>
                <input type="number" v-model="form.height" class="form-control" id="height" required>
              </div>
              <div class="form-group">
                <label for="user_id">Patient</label>
                <select v-model="form.user_id" class="form-control" id="user_id" required>
                  <option v-for="patient in patients" :key="patient.id" :value="patient.id">{{ patient.fullname }}</option>
                </select>
              </div>
              <div class="form-group">
                <label for="doctor_id">Doctor</label>
                <select v-model="form.doctor_id" class="form-control" id="doctor_id" required>
                  <option v-for="doctor in doctorsList" :key="doctor.id" :value="doctor.id">{{ doctor.fullname }}</option>
                </select>
              </div>
              <div class="form-group">
                <label for="created_at">Created At</label>
                <input type="datetime-local" v-model="form.created_at" class="form-control" id="created_at" required>
              </div>
              <button type="submit" class="btn btn-primary">Add Record</button>
            </form>
          </div>
          <div class="modal-footer">
            <button class="btn btn-secondary" @click="CloseModal">Close</button>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { mapGetters } from 'vuex';
  import axios from 'axios';
  
  export default {
    name: 'AddMedicalRecordModal',
    data() {
      return {
        openClose: this.visible,
        form: {
          weight: '',
          height: '',
          user_id: '',
          doctor_id: '',
          created_at: new Date().toISOString().slice(0, 16),
        },
        errors: null,
      };
    },
    props: {
      visible: Boolean,
    },
    computed: {
      ...mapGetters(['getPatients', 'getDoctors']),
      patients() {
        return this.getPatients;
      },
      doctorsList() {
        return this.getDoctors;
      },
    },
    methods: {
      async submitForm() {
        try {
          const response = await axios.post(
            this.$store.state.apiUrl + '/addRecord',
            {
              user_id: this.form.user_id,
              doctor_id: this.form.doctor_id,
              weight: this.form.weight,
              height: this.form.height,
              created_at: this.form.created_at,
            }
          );
  
          if (response.status === 201) {
            this.$swal.fire({
              title: 'Success!',
              text: response.data.message,
              icon: 'success',
            });
            this.form.weight = '';
            this.form.height = '';
            this.form.user_id = '';
            this.form.doctor_id = '';
            this.form.created_at = new Date().toISOString().slice(0, 16);
            this.openClose = !this.openClose;
            this.$emit('update:visible', false);
            this.$emit('modal-closed');
            this.$router.push('/admin/medicalRecords');
          }
        } catch (error) {
          this.errors = error.response.data.errors;
        }
      },
      CloseModal() {
        this.openClose = !this.openClose;
        this.$emit('update:visible', false);
        this.$emit('modal-closed');
      },
    },
    watch: {
      visible: {
        handler(newVal) {
          this.openClose = newVal;
        },
      },
    },
    mounted() {
      this.$store.dispatch('fetchDoctors');
      this.$store.dispatch('fetchPatients');
    },
  };
  </script>
  
  <style scoped>
  #addMedicalRecord .modal-body h4 {
    color: var(--global-color-primary);
    font-weight: 600;
  }
  
  #addMedicalRecord .modal-body {
    padding: 20px;
  }
  
  #addMedicalRecord .form-group {
    margin-bottom: 15px;
  }
  
  #addMedicalRecord .form-control {
    width: 100%;
  }
  </style>