<template>
  <v-dialog class v-model="showModal" @input="modalChanged">
    <template v-if="$store.state.Project.creatingListing">
      <v-progress-linear :indeterminate="true"></v-progress-linear>
    </template>
    <v-card class="pa-2" v-else>
      <v-card-text>{{ promptText }}</v-card-text>
      <v-text-field
        @change="importProp"
        :autofocus="true"
        name="fieldName"
        v-model="sourceUrl"
        placeholder="Enter the url of a property here"
      ></v-text-field>
      <v-card-actions>
        <p v-if="$store.state.Project.importErrors.length">
          <template v-for="error in $store.state.Project.importErrors">
            <v-alert outlined :key="error" color="error" icon="warning" :value="true">{{error}}</v-alert>
          </template>
        </p>
      </v-card-actions>
      <v-card-actions>
        <v-btn color="green" text @click="importProp()">Import</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>
<script>
export default {
  props: ["importModalVisible", "newProject"],
  data() {
    return {
      sourceUrl: "",
      showModal: false
    }
  },
  mounted: function() {
    // feb 2019 - needed as errors are getting saved in local storage... :(
    this.$store.commit("setImportErrors", { errors: [] })
  },
  computed: {
    currentProject() {
      return this.$store.state.Project.currentProject
    },
    promptText() {
      if (this.$store.state.Project.currentProject.id) {
        return "Add a new property to your collection:"
      } else {
        return "Get started by adding a property:"
      }
    }
  },
  methods: {
    importProp() {
      if (this.$store.state.Project.currentProject.id) {
        let params = {
          project: this.$store.state.Project.currentProject,
          sourceUrl: this.sourceUrl
        }
        this.$store.dispatch("addUrlToProject", params)
      } else {
        this.$store.dispatch("newProjectFromUrl", this.sourceUrl)
      }
    },
    // https://github.com/vuetifyjs/vuetify/issues/4057
    // idea for below from above.
    // Works because
    // v-model directive is just sugar for value prop + input event
    modalChanged(modalIsOpen) {
      // roundabout way of doing this but only one I can find that works.
      // When the modal is closed I need to fire an event to the
      // container where importModalVisible can be set to false
      if (!modalIsOpen) {
        this.$emit("hideImportModal")
      }
      //
    }
  },
  watch: {
    importModalVisible(newValue) {
      // If I try using importModalVisible directly
      // I get a warning about mutating a prop
      this.showModal = newValue
    },
    "$store.state.Project.showImportListingModal"(newValue, oldValue) {
      this.showModal = newValue
      // if ((newValue === false) && (oldValue === true)) {
      //   this.$emit('hideImportModal')
      // }
    },
    "$store.state.Project.currentProject"(currentProjectVal) {
      if (currentProjectVal.id) {
        var listingModel = "rental_listings"
        if (currentProjectVal.model_name === "SaleListing") {
          listingModel = "sale_listings"
        }
        // this.$router.push({
        //   name: 'projectHomePage',
        //   params: {
        //     projectUuid: currentProjectVal.id
        //   }
        // })
        this.$emit("hideImportModal")
      }
    }
  }
}
</script>