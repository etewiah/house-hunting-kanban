<template>
  <v-layout row wrap justify-center class="my-0">
    <v-flex>
    </v-flex>
    <v-flex sm12 offset-xs0>
      <v-layout row wrap justify-center class="my-0">
        <data>
          <ListingSummary :property="currentListing"></ListingSummary>
        </data>
      </v-layout>
    </v-flex>
  </v-layout>
</template>
<script>
import ListingSummary from '@jsroot/pisocake/components/ListingSummary'
// import PwbMap from '@jsroot/pisocake/components/PwbMap'


export default {
  components: {
    // FeedbackModal,
    // ListingDetailsModal,
    // ImportListingModal,
    ListingSummary,
    // PwbMap
  },
  watch: {
    '$route': {
      handler(to, from) {
        // var pageParams = {
        //   slug: "home",
        //   props_filter: "highlighted_rent_daily"
        // }
        this.$store.dispatch('loadProject', to.params.projectUuid)
        // this.$nextTick(function() {
        //   this.$store.dispatch('loadQueryResultsForPage', 'home')
        // })
      },
      immediate: true
    }
  },
  methods: {
    saveTitle() {
      let params = {
        title: this.newTitleField.fieldValue
      }
      this.$store.dispatch('updateProject', params)
    },
  },
  data: function() {
    return {
    }
  },
  computed: {
    currentListing() {
      let currentListing = {}
      let currentListingId = parseInt(this.$route.params.listingId)
      debugger
      this.$store.state.Project.currentProject.for_sale.forEach(
        function(listing) {
          if (currentListingId === listing.uuid) {
            currentListing = listing
          }
        }
      )
      return currentListing
    }
  }
}
</script>
<style scoped>
</style>