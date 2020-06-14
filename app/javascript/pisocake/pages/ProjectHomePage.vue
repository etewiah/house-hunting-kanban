<template>
  <v-row pa-0 justify="center">
    <v-col cols="22" sm="12" md="12">
      <div>
        <div
          class="d-flex justify-center headline font-weight-regular pa-2"
          v-if="$store.state.Project.currentProject.title"
          auto-grow
          filled
          rows="1"
          readonly
          v-text="$store.state.Project.currentProject.title"
          name="input-7-4"
        ></div>
        <div class="ma-2" style="width: 100%" v-else>
          <v-card>
            <v-text-field
              placeholder="Type a title for this project here"
              @change="saveTitle"
              :multi-line="newTitleField.multiLine"
              :required="newTitleField.required"
              :rules="newTitleField.validationRules"
              name
              :label="newTitleField.label"
              v-model="newTitleField.fieldValue"
            ></v-text-field>
            <v-btn color="white" text @click="saveTitle()">Save</v-btn>
          </v-card>
        </div>
        <v-spacer></v-spacer>
        <div></div>
      </div>
    </v-col>
    <v-col class="pa-0" cols="22" sm="12" md="4">
      <v-layout row wrap justify-center class="pl-5 pr-2 mx-0">
        <v-flex
          @click="showListing(property)"
          xs12
          v-for="(property) in $store.state.Project.currentProject.for_sale"
          :key="property.Reference"
        >
          <ListingSummary :property="property"></ListingSummary>
        </v-flex>
        <v-flex class="ma-1 pa-5" xs12>
          <v-btn color="success" large @click="createProject">
            <span class="del-photo-btn group">Add new property</span>
          </v-btn>
          <v-btn color="success" large @click="giveFeedback">
            <span class="del-photo-btn group">Feedback</span>
          </v-btn>
        </v-flex>
      </v-layout>
    </v-col>
    <v-col class="pa-0" cols="22" sm="12" md="8">
      <v-layout row wrap justify-center class="px-2 py-1">
        <v-flex class="pr-5" xs12>
          <ListingDetails></ListingDetails>
        </v-flex>
      </v-layout>
      <template v-if="mapMarkers">
        <pwb-map
          style="min-height: 600px;"
          :mapMarkers="mapMarkers"
          :fallbackCenter="fallbackCenter"
          :zoom="15"
        ></pwb-map>
      </template>
    </v-col>
    <FeedbackModal
      @hideFeedbackModal="hideFeedbackModal"
      :feedbackModalVisible="feedbackModalVisible"
    ></FeedbackModal>
    <ImportListingModal @hideImportModal="hideImportModal" :importModalVisible="importModalVisible"></ImportListingModal>
    <!-- <ListingDetailsModal
      @hideListingModal="hideListingModal"
      :listingModalVisible="listingModalVisible"
    ></ListingDetailsModal>-->
  </v-row>
</template>
<script>
import FeedbackModal from "@jsroot/pisocake/components/FeedbackModal"
import ListingDetails from "@jsroot/pisocake/components/ListingDetails"
// import ListingDetailsModal from "@jsroot/pisocake/components/ListingDetailsModal"
import ImportListingModal from "@jsroot/pisocake/components/ImportListingModal"
import ListingSummary from "@jsroot/pisocake/components/ListingSummary"
import PwbMap from "@jsroot/pisocake/components/PwbMap"

export default {
  components: {
    FeedbackModal,
    ListingDetails,
    // ListingDetailsModal,
    ImportListingModal,
    ListingSummary,
    PwbMap
  },
  watch: {
    $route: {
      handler(to, from) {
        // var pageParams = {
        //   slug: "home",
        //   props_filter: "highlighted_rent_daily"
        // }
        this.$store.dispatch("loadProject", to.params.projectUuid)
        if (to.params.listingUuid) {
          this.$store.commit("setActiveListingUuid", {
            uuid: to.params.listingUuid
          })
        }
      },
      immediate: true
    }
  },
  methods: {
    saveTitle() {
      let params = {
        title: this.newTitleField.fieldValue
      }
      this.$store.dispatch("updateProject", params)
    },
    createProject() {
      this.importModalVisible = true
    },
    giveFeedback() {
      this.feedbackModalVisible = true
    },
    showListing(listing) {
      this.$store.commit("activateNewListing", { listing: listing })
      this.listingModalVisible = true
    },
    hideListingModal() {
      this.listingModalVisible = false
    },
    hideImportModal() {
      this.importModalVisible = false
    },
    hideFeedbackModal() {
      this.feedbackModalVisible = false
    }
  },
  data: function() {
    return {
      newTitleField: {},
      feedbackModalVisible: false,
      importModalVisible: false,
      // currentModalListing: {},
      listingModalVisible: false
    }
  },
  computed: {
    fallbackCenter() {
      // var mapMarker = this.$store.state.Project.currentAgency.agency_map_marker
      // return mapMarker ? mapMarker.position : { lat: 15, lng: 15 }
      return {
        lat: 15,
        lng: 15
      }
    },
    mapMarkers() {
      let mapMarkers = []
      let properties = this.$store.state.Project.currentProject.for_sale || []
      var that = this
      properties.forEach(function(property) {
        if (property.latitude && property.latitude !== 0.0) {
          var resolvedRouter = that.$router.resolve({
            name: "projectListingPage",
            params: {
              listingUuid: property.uuid
              // projectUuid:
            }
          })
          mapMarkers.push({
            show_url: resolvedRouter.href,
            // id: property.uuid,
            title: property.title,
            // image_url: property.primary_image_url,
            position: {
              lat: property.latitude,
              lng: property.longitude
            }
          })
        }
      })
      return mapMarkers
    }
  }
}
</script>
<style scoped>
</style>