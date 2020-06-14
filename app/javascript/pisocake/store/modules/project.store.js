import apiPublicService from "@jsroot/pisocake/services/api-public"

// initial state
const state = {
  // is404: false,
  currentProject: {},
  // allProjectsSummary: [],
  // allProjectsSummary: function () {
  //   return []
  // },
  importErrors: [],
  creatingListing: false,
  showImportListingModal: false
}

const getters = {
  // cookieStatus: state => {
  //   return localStorage.getItem('cookie:accepted') || false
  // }
  getLocalProjects: (state, getters) => (id) => {
    let allProjectsSummary = JSON.parse(localStorage.getItem("hh-projects"))
    return allProjectsSummary || []
  },
  // getFooterNavLinks: (state) => {
  //   return state.clientSettings.navigation.footer
  // }
  // parameterized getter
  // getMovieById: (state, getters) => (id) => {
  //   counter++
  //   return state.movies.find(movie => movie.id === id)
  // }
}


// actions
const actions = {
  updateProject: function ({ commit, state }, params) {
    let apiUrl = this.getters.basePublicApiUrl + '/projects/' + state.currentProject.id
    apiPublicService().put(apiUrl, {
      title: params.title
    }).then((response) => {
      if (response.status === 200) {
        let project = response.data.project
        commit('setProject', { project: project })
        commit('setProjectListings', { project: project })
      }
    }, (err) => { })
  },
  loadProject: function ({ commit }, projectUuid) {
    let apiUrl = this.getters.basePublicApiUrl + '/projects/' + projectUuid
    apiPublicService().get(apiUrl).then((response) => {
      if (response.status === 200) {
        let project = response.data.project
        commit('setProject', { project: project })
        commit('setProjectListings', { project: project })
      }
    }, (err) => {
      console.log(err)
    })
  },
  newProjectFromUrl({ commit, state }, importUrl) {
    // importUrl = "https://www.zoopla.co.uk/for-sale/details/48344752"
    let apiUrl = this.getters.basePublicApiUrl + "/imports/project_from_webpage/"
    state.creatingListing = true
    // feb 2019 - using get below to avoid issues with initial auth token
    apiPublicService().get(apiUrl, {
      params: {
        url: importUrl
      }
    }).then((response) => {
      if (response.status === 200) {
        if (response.data.success) {
          let project = response.data.project
          commit('setProject', { project: project })
          commit('setProjectListings', { project: project })
        } else {
          commit('setImportErrors', { errors: [response.data.error_message] })
        }
      }
    }, (err) => {
      commit('setImportErrors', { errors: ["Sorry, there has been an error. " + err.message] })
    })

  },
  addUrlToProject({ commit, state }, params) {
    let apiUrl = this.getters.basePublicApiUrl + "/imports/add_webpage/"
    state.creatingListing = true
    apiPublicService().get(apiUrl, {
      params: {
        url: params.sourceUrl,
        project_uuid: params.project.id
      }
    }).then((response) => {
      if (response.status === 200) {
        if (response.data.success) {
          let project = response.data.project
          commit('setProject', { project: project })
          commit('setProjectListings', { project: project })
          // let listing = response.data.listing
          // commit('setNewListing', { listing: listing })
        } else {
          commit('setImportErrors', { errors: [response.data.error_message] })
        }
      }
    }, (err) => {
      commit('setImportErrors', { errors: ["Sorry, there has been an error. " + err.message] })
    })

  },
}

// mutations
const mutations = {
  clearCurrentProject: (state, { }) => {
    state.currentProject = {}
  },
  setImportErrors: (state, { errors }) => {
    state.creatingListing = false
    state.importErrors = errors
  },
  // setNewListing: (state, { listing }) => {
  //   state.creatingListing = false
  //   // might be worth checking here to ensure a duplicate is not added:
  //   state.currentProject.for_sale.push(listing)
  //   state.showImportListingModal = false
  // },
  setProject: (state, { project }) => {
    state.creatingListing = false
    state.showImportListingModal = false
    state.currentProject = project
    let projectSaved = false
    // state.allProjectsSummary.forEach(function (savedProject) {
    //   if (savedProject.id === project.id) {
    //     savedProject.title = project.title
    //     projectSaved = true
    //   }
    // })
    // above was implementation with vue-persist library
    let allProjectsSummary = JSON.parse(localStorage.getItem("hh-projects")) || []

    allProjectsSummary.forEach(function (savedProject) {
      // check each item in localStorage
      if (savedProject.id === project.id) {
        savedProject.title = project.title
        // if value exists then no need to save it again
        projectSaved = true
      }
    })

    if (!projectSaved) {
      allProjectsSummary.push({
        id: project.id,
        title: project.title
      })
      localStorage.setItem("hh-projects", JSON.stringify(allProjectsSummary))
    }
  }
  // setAppWideError: (state, { errorObject }) => {
  //   state.errorSnackbar = errorObject
  // },
  // setAppWideSuccess: (state, { successMessage }) => {
  //   let successMessage = successMessage || "Success"
  //   let successObject = {
  //     snackbar: true,
  //     text: successMessage,
  //     top: true,
  //     color: 'green',
  //     timeout: 9000
  //   }
  //   state.errorSnackbar = successObject
  // },
  // // // below called by search store
  // setSearchPageContent: (state, { result }) => {
  //   state.currentPage = result.page
  //   state.currentPageParts = result.page_parts
  // }
}


export default {
  state,
  getters,
  actions,
  mutations
}