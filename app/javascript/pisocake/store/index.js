/**
 * Vuex
 *
 * @library
 *
 * https://vuex.vuejs.org/en/
 */

// Lib imports
import Vue from 'vue'
import Vuex from 'vuex'

// Store functionality
import modules from './modules'
// import actions from './actions'
// import getters from './getters'
// import mutations from './mutations'
// import state from './state'


const getters = {
  basePublicApiUrl: state => {
    return '/api_public/v1/' + 'en'
    //  state.coreStore.currentLocale
  },
}
Vue.use(Vuex)

// import VuexPersist from 'vuex-persist'
// const vuexPersist = new VuexPersist({
//   key: 'chattymaps',
//   storage: localStorage,
//   modules: ['projectsStore'], //only save projectsStore module
//   filter: (mutation) => (mutation.type == 'setProject' || mutation.type == 'dummy')
// })


// Create a new store
const store = new Vuex.Store({
  modules,
  // actions,
  getters,
  // mutations,
  // state
})

export default store
