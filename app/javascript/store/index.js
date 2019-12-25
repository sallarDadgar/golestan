import Vue from "vue"
import Vuex from "vuex"
import createPersistedState from 'vuex-persistedstate'
// import * as Cookies from 'js-cookie'

Vue.use(Vuex);

export default new Vuex.Store({
  plugins: [createPersistedState({
    storage: window.sessionStorage,
  })],
  state: {
    user: [],
    all_stusons: [],
    student_id: 0
  },

  actions: {
    addUser(context, user_data) {
      context.commit('SET_USER', user_data)
      //in the axios block: store.dispatch('addUser', response.data)
    },
    initialStusons(context, stusons_data){
      context.commit('SET_ALL_STUSONS', stusons_data)
    },
    initiateStudentID(context, payload){
      context.commit('SET_STUDENT_ID', payload)
    }
  },

  mutations: {
    SET_USER(state, user_data){
      state.user = user_data
    },
    SET_ALL_STUSONS(state, payload){
      state.all_stusons = payload
    },
    SET_STUDENT_ID(state, payload){
      state.student_id = payload
    }
  },

  getters: {
    get_user(state) {
      return state.user
    },
    get_stusons(state){
      return state.all_stusons
    },
    get_student_id(state){
      return state.student_id
    }
  },
})