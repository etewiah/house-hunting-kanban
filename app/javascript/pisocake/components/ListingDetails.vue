<template>
  <v-card class="pa-2">
    <v-card-title class="text-center justify-center py-6">
      <h1 class="font-weight-bold title basil--text">{{listing.title}}</h1>
    </v-card-title>

    <v-tabs v-model="tab" background-color="transparent" color="basil" grow>
      <v-tab>Pictures</v-tab>
      <v-tab>Description</v-tab>
      <v-tab>Notes</v-tab>
    </v-tabs>

    <v-tabs-items v-model="tab">
      <v-tab-item>
        <v-card flat color="basil">
          <v-flex xs12></v-flex>
          <v-card-text>
            <v-layout row wrap class="my-0">
              <v-flex xs4 sm3 md2 v-for="(photo) in listing.image_urls" :key="photo">
                <v-img :src="photo" aspect-ratio="1"></v-img>
              </v-flex>
            </v-layout>
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item>
        <v-card flat color="basil">
          <v-card-text>
            <v-flex xs12>{{listing.description}}</v-flex>
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item>
        <v-card flat color="basil">
          <v-card-text>
            <v-layout row wrap class="my-0">
              <v-flex v-if="listing.notes && listing.notes.length" xs12>
                <h5>Your notes:</h5>
              </v-flex>
              <v-flex
                xs12
                sm6
                md4
                v-for="(note) in listing.notes"
                :key="note.id"
                class="ellipsis"
              >
                <v-card class="ma-1" elevation-4>
                  <v-card-text style="white-space: normal;">
                    <div>{{note.title}}</div>
                  </v-card-text>
                </v-card>
              </v-flex>
              <v-flex xs12>
                <div>New note:</div>
                <template v-if="$store.state.Listing.creatingListingNote">
                  <v-progress-linear :indeterminate="true"></v-progress-linear>
                </template>
                <v-card v-else class="ma-1" elevation-4>
                  <v-card-text>
                    <div>
                      <v-text-field
                        :autofocus="newNoteField.autofocus"
                        :multi-line="newNoteField.multiLine"
                        :required="newNoteField.required"
                        :rules="newNoteField.validationRules"
                        name
                        :label="newNoteField.label"
                        v-model="newNoteField.fieldValue"
                      ></v-text-field>
                      <v-btn color="green" text @click="saveNote()">Save</v-btn>
                    </div>
                  </v-card-text>
                </v-card>
              </v-flex>
            </v-layout>
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </v-card>
</template>
<script>
export default {
  // props: ["listing"],
  data() {
    return {
      tab: null
    }
  },
  computed: {
    newNoteField() {
      return this.$store.state.Listing.newNoteField
    },
    listing() {
      // debugger
      return this.$store.getters.getActiveListing
    }
  },
  methods: {
    saveNote() {
      let params = {
        listing: this.listing,
        newNoteValue: this.newNoteField.fieldValue
      }
      this.$store.dispatch("saveListingNote", params)
    }
  },
  watch: {}
}
</script>