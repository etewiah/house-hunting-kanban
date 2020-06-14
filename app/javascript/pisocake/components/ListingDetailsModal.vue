<template>
  <v-dialog v-model="showModal" @input="modalChanged">
    <v-card class="pa-2">
      <v-card-text>
        <h3>
          {{listing.title}}
        </h3>
      </v-card-text>
      <v-divider></v-divider>
      <v-layout row wrap class="my-0">
        <v-flex xs12 sm6>
          <v-layout row wrap class="my-0">
            <v-flex xs4 sm3 md2 v-for="(photo) in listing.image_urls" :key="photo">
              <v-img :src="photo" aspect-ratio="1"></v-img>
            </v-flex>
            <v-flex xs12>
              {{listing.description}}
            </v-flex>
          </v-layout>
        </v-flex>
        <v-flex xs12 sm6>
          <v-layout row wrap class="my-0">
            <v-flex v-if="listing.notes && listing.notes.length" xs12>
              <h5>
                Your notes:
              </h5>
            </v-flex>
            <v-flex xs12 sm6 md4 v-for="(note, index) in listing.notes" :key="note.id" class="ellipsis">
              <v-card class="ma-1" elevation-4>
                <v-card-text style="white-space: normal;" >
                  <div>
                    {{note.title}}
                  </div>
                </v-card-text>
              </v-card>
            </v-flex>
            <v-flex xs12>
              <div> New note:
              </div>
              <template v-if="$store.state.Listing.creatingListingNote">
                <v-progress-linear :indeterminate="true"></v-progress-linear>
              </template>
              <v-card v-else class="ma-1" elevation-4>
                <v-card-text>
                  <div>
                    <v-text-field :autofocus="newNoteField.autofocus" :multi-line="newNoteField.multiLine" :required="newNoteField.required" :rules="newNoteField.validationRules" name="" :label="newNoteField.label" v-model="newNoteField.fieldValue"></v-text-field>
                    <v-btn color="green" text @click="saveNote()">
                      Save
                    </v-btn>
                  </div>
                </v-card-text>
              </v-card>
            </v-flex>
          </v-layout>
        </v-flex>
      </v-layout>
      <v-card-actions>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>
<script>
export default {
  props: ["listingModalVisible"],
  data() {
    return {
      showModal: false
    }
  },
  computed: {
    newNoteField() {
      return this.$store.state.Listing.newNoteField
    },
    listing() {
      return this.$store.state.Listing.activeListing
    }
  },
  methods: {
    saveNote() {
      let params = {
        listing: this.listing,
        newNoteValue: this.newNoteField.fieldValue
      }
      this.$store.dispatch('saveListingNote', params)
    },
    // https://github.com/vuetifyjs/vuetify/issues/4057
    // idea for below from above.
    // Works because
    // v-model directive is just sugar for value prop + input event
    modalChanged(modalIsOpen) {
      // roundabout way of doing this but only one I can find that works.
      // When the modal is closed I need to fire an event to the 
      // container where listingModalVisible can be set to false
      if (!modalIsOpen) {
        this.$emit('hideListingModal')
      }
      // 
    }
  },
  watch: {
    'listingModalVisible'(newValue) {
      // If I try using listingModalVisible directly 
      // I get a warning about mutating a prop 
      this.showModal = newValue
    },
    // '$store.state.Listing.creatingListingNote'(newValue, oldValue) {
    //   if ((newValue === false) && (oldValue === true)) {
    //     this.$emit('hideListingModal')
    //   }
    // }
  }
}
</script>