/* eslint no-console: 0 */

import Vue from 'vue'

import 'vuetify/src/styles/styles.sass'
// import Vuetify from "vuetify"
// import Vuetify from 'vuetify/lib'


// https://vuetifyjs.com/en/framework/icons#installing-fonts
// import 'material-design-icons-iconfont/dist/material-design-icons.css' // Ensure you are using css-loader
// PageSpeed advices removing above as its top recommendation for improving performance
// Consider using <link rel=preload> to prioritize fetching resources that are currently requested 
// import i18n from "@jsroot/shared/i18n"

// import DateFilter from '@jsroot/shared/filters/SimpleDate' // Import date
// Vue.filter('date', DateFilter) // register filter globally


// import App from '@jsroot/be-admin/App.vue'
import App from '@pisocakeroot/app.vue'
import store from "@pisocakeroot/store/index"
import router from "@pisocakeroot/router/index"

import vuetify from '../plugins/vuetify' // path to vuetify export

// import SimpleDateFilter from '@wswwroot/filters/SimpleDate' // Import date
// Vue.filter('simpleDate', SimpleDateFilter) // register filter globally
// import SimpleTimeFilter from '@wswwroot/filters/SimpleTime' // Import date
// Vue.filter('simpleTime', SimpleTimeFilter) // register filter globally

import * as VueGoogleMaps from 'vue2-google-maps'

Vue.use(VueGoogleMaps, {
  load: {
    // TODO - inject key via server side
    key: 'your_key_here',
    // libraries: 'places', // This is required if you use the Autocomplete plugin
    // OR: libraries: 'places,drawing'
    // OR: libraries: 'places,drawing,visualization'
    // (as you require)
  }
})


document.addEventListener('DOMContentLoaded', () => {
  // const el = document.body.appendChild(document.createElement('hell'))
  const app = new Vue({
    el: "#wsww-app",
    vuetify,
    router,
    store,
    // i18n,
    render: h => h(App)
  })
  console.log(app)
})

Vue.config.performance = true
// Above enables vue specific user timing info in chrome debugger

