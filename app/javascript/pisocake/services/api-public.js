// TODO - figure out how I might use this in nuxt
import axios from 'axios'
// Nov 2018 need a different store for each pack so below not feasible:
// import store from "@jsroot/theme-malaga-admin/store"
// import coreStore from "@jsroot/shared/store/modules/core"
// Or I could set " window.store = store" in init and use global object
// used by:
// shared-admin/store/modules/pageEdit.js
export default () => {
  const apiPublicService = axios.create({
    // baseURL: `http://api.pearson.com/v2/dictionaries`,
    withCredentials: false,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest'
    }
  })
  // axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"


  // // Add a request interceptor
  // apiPublicService.interceptors.request.use(function(config) {
  //   // Do something before request is sent
  //   return config;
  // }, function(error) {
  //   // Do something with request error
  //   return Promise.reject(error);
  // });

  apiPublicService.interceptors.response.use(function(response) {
    // console.log(axios)
    // Do something with response data
    if (response.headers["x-csrf-token"]) {
      axios.defaults.headers.common["X-CSRF-Token"] = response.headers["x-csrf-token"]
    }
    if (response.data.error) {
      // console.log(coreStore)
      var errorObject = {
        // snackbar: true,
        text: response.data.error,
        // top: true,
        // color: 'red',
        // timeout: 10000
      }
      app.__vue__.$store.commit('setPageError', { errorObject: errorObject })
      // Unlike setAppWideError, above has to be handled by individual 
      // routes which choose to observe pageError
    }
    else{
      return response;
    }

  }, function(error) {
    if (error.response.status === 404) {
      // alert("page not found")
      // not entirely sure if below is a good idea:
      // app.__vue__.$store.commit('set404', { is404: true })
      // March 2019 - decided to stop doing above as post 404 errors also
      // result in above being triggered
      // Could try checking for get requests only but I'm
      // not even fully convinced I'll be able to use with nuxt...
    } else {
      // var errorText = "Sorry, there has been an error"
      // if (error.response.data.error) {
      //   errorText = error.response.data.error
      // }
      // // console.log(coreStore)
      // var errorObject = {
      //   snackbar: true,
      //   text: errorText,
      //   top: true,
      //   color: 'red',
      //   timeout: 10000
      // }
      // // not entirely sure if below is a good idea:
      // app.__vue__.$store.commit('setAppWideError', { errorObject: errorObject })
    }
    // Do something with response error
    return Promise.reject(error);
  });

  return apiPublicService
}