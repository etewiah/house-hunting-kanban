import apiPublicService from "@jsroot/pisocake/services/api-public"

// initial state
const state = {
  activeListing: null,
  activeListingUuid: null,
  creatingListingNote: false,
  newNoteField: {},
  currentListings: []
}

const getters = {
  getActiveListing: state => {
    if (state.activeListing) {
      return state.activeListing
    } else if (state.activeListingUuid) {
      // all this is so that I can set active listing from the url
      // which is useful so I can click on the map and reload...
      let activeListing = state.currentListings[0] || {}
      state.currentListings.forEach(function (listing) {
        if (listing.uuid === state.activeListingUuid) {
          activeListing = listing
        }
      })
      return activeListing
    } else {
      return state.currentListings[0] || {}
    }
  }
  // parameterized getter
  // getMovieById: (state, getters) => (id) => {
  //   counter++
  //   return state.movies.find(movie => movie.id === id)
  // }
}

// actions
const actions = {
  saveListingNote({ commit, state }, params) {
    let apiUrl = this.getters.basePublicApiUrl + "/listings/add_note/" + params.listing.uuid
    state.creatingListingNote = true
    apiPublicService().put(apiUrl, {
      note: params.newNoteValue
    }).then((response) => {
      if (response.status === 200) {
        let listing = response.data.listing
        commit('setNewListingNote', { listing: listing })
      }
    }, (err) => {
      console.log(err)
    })

  },
}

// mutations
const mutations = {
  setProjectListings: (state, { project }) => {
    state.currentListings = project.for_rental.concat(project.for_sale)
  },
  setNewListingNote: (state, { listing }) => {
    state.creatingListingNote = false
    state.activeListing = listing
    state.newNoteField.fieldValue = ""
  },
  activateNewListing: (state, { listing }) => {
    state.activeListing = listing
  },
  setActiveListingUuid: (state, { uuid }) => {
    state.activeListingUuid = uuid
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}