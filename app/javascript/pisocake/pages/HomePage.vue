<template>
  <v-container class="justify-center" fluid>
    <v-row align="center" justify="center">
      <v-col cols="22" sm="12" md="8">
        <div class="title pa-2 my-4 row justify-center">
          Create instant pages to discuss your house hunt with anyone you share the url with
          <!-- House Hunting should be a PisoCake -->
        </div>
        <div class="subtitle-1 px-2 pb-3 mb-5 mt-0 row justify-center">No need to create an account</div>
        <v-card class="elevation-12">
          <v-list-item dark class="green--text primary main-prompt-top">
            <v-list-item-content>
              <v-list-item-title class="headline">Start your house hunting now</v-list-item-title>
              <v-list-item-subtitle></v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
          <v-card-text>
            <v-form v-on:submit.prevent ref="mainForm">
              <v-text-field
                @change="importProp"
                :autofocus="true"
                name="fieldName"
                :rules="[rules.minCounter10, rules.friendlyUrl]"
                v-model="sourceUrl"
                placeholder="Enter the url of a property here"
              ></v-text-field>
              <v-card-actions>
                <p v-if="$store.state.Project.importErrors.length">
                  <template v-for="error in $store.state.Project.importErrors">
                    <v-alert
                      outlined
                      :key="error"
                      color="error"
                      icon="warning"
                      :value="true"
                    >{{error}}</v-alert>
                  </template>
                </p>
              </v-card-actions>
              <v-card-actions>
                <v-spacer />
                <v-btn color="primary" @click="importProp()">Create</v-btn>
              </v-card-actions>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    <v-row align="center" justify="center">
      <v-expand-x-transition>
        <div
          v-show="showTrans"
          class="display-1 pa-2 ma-4 row justify-center"
        >House Hunting should be a PisoCake</div>
      </v-expand-x-transition>
    </v-row>
    <v-layout row wrap justify-center class="my-0">
      <!-- <ImportListingModal
        @hideImportModal="hideImportModal"
        :importModalVisible="importModalVisible"
      ></ImportListingModal>-->
      <v-flex
        v-if="$store.getters.getLocalProjects().length > 0"
        style="margin-top: 1%;"
        justify-center
        sm10
        offset-sm2
        xs12
        md4
        offset-md4
      >
        <v-card class="pa-2">
          <v-card-text>Your projects:</v-card-text>
          <v-card-actions>
            <v-layout row wrap class="my-0">
              <v-flex
                xs12
                sm6
                md4
                :key="project.id"
                v-for="project in $store.getters.getLocalProjects()"
              >
                <v-btn
                  style="white-space: normal !;"
                  class="tall-btn"
                  block
                  text
                  color="orange"
                  :to="{name: 'projectHomePage',params: { projectUuid: project.id }}"
                >{{project.title || "Untitled project"}}</v-btn>
              </v-flex>
            </v-layout>
          </v-card-actions>
        </v-card>
      </v-flex>
      <v-flex md4></v-flex>
    </v-layout>
  </v-container>
</template>
<script>
// import ImportListingModal from "@pisocakeroot/components/ImportListingModal"
// import ListingSummary from '@pisocakeroot/components/ListingSummary'

export default {
  components: {
    // ImportListingModal
    // ListingSummary
  },
  mounted: function() {
    var that = this
    setTimeout(function() {
      that.showTrans = true
    }, 1500)
    // this.$store.dispatch('refreshCsrf')
  },
  watch: {
    "$store.state.Project.currentProject"(currentProjectVal) {
      if (currentProjectVal.id) {
        var listingModel = "rental_listings"
        if (currentProjectVal.model_name === "SaleListing") {
          listingModel = "sale_listings"
        }
        this.$router.push({
          name: 'projectHomePage',
          params: {
            projectUuid: currentProjectVal.id
          }
        })
        // this.$emit("hideImportModal")
      }
    }
  },
  methods: {
    importProp() {
      if (this.$refs.mainForm.validate()) {
        // if (this.$store.state.Project.currentProject.id) {
        //   let params = {
        //     project: this.$store.state.Project.currentProject,
        //     sourceUrl: this.sourceUrl
        //   }
        //   this.$store.dispatch("addUrlToProject", params)
        // } else {
        this.$store.dispatch("newProjectFromUrl", this.sourceUrl)
      }
    }
    // createProject() {
    //   this.$store.commit("clearCurrentProject", {})
    //   this.importModalVisible = true
    // },
    // hideImportModal() {
    //   this.importModalVisible = false
    // }
  },
  data: function() {
    return {
      // importModalVisible: false,
      showTrans: false,
      sourceUrl: "",
      rules: {
        minCounter10: value => value.length >= 10 || "Min 10 characters",
        required: value => !!value || "Required.",
        friendlyUrl(value) {
          // console.log("validating value")
          if (/^(http|https):\/\/+[\www\d]+\.[\w]+(\/[\w\d]+)?/.test(value)) {
            // if (/^[a-z0-9\-]*$/.test(value)) {
            return true
          }
          return "Must be a valid url"
        }
      }
    }
  },
  computed: {
    // topNavLinks() {
    //   return []
    // }
  }
}
</script>
<style>
.tall-btn .v-btn__content {
  white-space: normal !important;
}
</style>