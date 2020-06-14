<template>
  <v-dialog class="" v-model="showModal" @input="modalChanged" max-width="600px">
    <template v-if="submitting">
      <v-card class="pa-2">
        <v-card-text>
        <h3>Thank you for your feedback</h3>
        <v-progress-linear :indeterminate="true"></v-progress-linear>
        </v-card-text>
      </v-card>
    </template>
    <v-card class="pa-2" v-else>
      <v-card-text>
        We would love to hear what you think of this project
      </v-card-text>
      <v-text-field :autofocus="true" name="" v-model="feedbackData.name" placeholder="" label="Your name (optional)"></v-text-field>
      <v-textarea name="" v-model="feedbackData.other" placeholder="" label="Your feedback"></v-textarea>
      <v-text-field name="" v-model="feedbackData.email" placeholder="" label="Your email (optional)"></v-text-field>
      <v-card-actions>
        <p v-if="showErrorMsg">
            <v-alert outlined color="error" icon="warning" :value="true">
              Please enter some feedback
            </v-alert>
        </p>
      </v-card-actions>
      <v-card-actions>
        <v-btn color="green" text @click="submitFeedback()">
          Submit
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>
<script>
export default {
  props: ["feedbackModalVisible", "newProject"],
  data() {
    return {
      submitting: false,
      feedbackData: {
        positive: "",
        negative: "",
        other: ""
      },
      sourceUrl: "",
      showModal: false,
      // dataEntered: false,
      showErrorMsg: false
    }
  },
  mounted: function() {
    // feb 2019 - needed as errors are getting saved in local storage... :(
    this.$store.commit('setImportErrors', { errors: [] })
  },
  computed: {
    currentProject() {
      return this.$store.state.Project.currentProject
    }
    // promptText() {
    // }
  },
  methods: {
    submitFeedback() {
      if (this.$store.state.Project.currentProject.id) {
        this.feedbackData.project_uuid = this.$store.state.Project.currentProject.id
      }

      if (this.feedbackData.other.length < 2) {
        this.showErrorMsg = true
        return
      } else {
        this.showErrorMsg = false
      }
      this.$store.dispatch('saveFeedback', this.feedbackData)
      this.submitting = true
      setTimeout(() => {
        this.submitting = false
        this.$emit('hideFeedbackModal')
      }, 2000);
    },
    // https://github.com/vuetifyjs/vuetify/issues/4057
    // idea for below from above.
    // Works because
    // v-model directive is just sugar for value prop + input event
    modalChanged(modalIsOpen) {
      // roundabout way of doing this but only one I can find that works.
      // When the modal is closed I need to fire an event to the 
      // container where feedbackModalVisible can be set to false
      if (!modalIsOpen) {
        this.$emit('hideFeedbackModal')
      }
      // 
    }
  },
  watch: {
    'feedbackModalVisible'(newValue) {
      // If I try using feedbackModalVisible directly 
      // I get a warning about mutating a prop 
      this.showModal = newValue
    },
    '$store.state.Project.showImportListingModal'(newValue, oldValue) {
      this.showModal = newValue
      // if ((newValue === false) && (oldValue === true)) {
      //   this.$emit('hideFeedbackModal')
      // }
    },
    '$store.state.Project.currentProject'(currentProjectVal) {
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
        this.$emit('hideFeedbackModal')
      }
    }
  }
}
</script>