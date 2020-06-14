<template>
  <div>
    <v-card class="mt-1 pb-2" :color="listingColor" :dark="listingColor === 'primary'" hover>
      <v-card-actions>
        <v-btn class="pl-2" icon>
          <v-icon>mdi-local-hotel</v-icon>
          <span class="info-text pl-2">{{property.Bedrooms }}</span>
        </v-btn>
        <v-btn class="ml-5" icon>
          <v-icon class="pb-1">mdi-hot-tub</v-icon>
          <span class="info-text pl-2">{{property.Bathrooms }}</span>
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn icon>
          <v-icon class>mdi-aspect-ratio</v-icon>
          <span class="info-text pl-2 pr-4">{{property.Built }}</span>
        </v-btn>
      </v-card-actions>
      <div
        v-if="mainImageUrl"
        class="summ-image"
        :style="{
            backgroundPosition: 'center', backgroundSize: 'cover', backgroundImage: 'url(' + mainImageUrl + ')' }"
      ></div>
      <h5 class="px-2">
        <!-- <div v-for="(note) in property.notes" :key="note.id" class="ellipsis">
          {{note.title}}
        </div>-->
      </h5>
      <!-- <v-card>
        <v-btn @click="showEdit()" color="blue" dark small absolute top right fab>
          <v-icon>mdi-pencil</v-icon>
        </v-btn>
      </v-card> -->
      <v-card-actions>
        <h4 class="ellipsis ma-1 pa-1">{{property.title}}</h4>
        <h6 class="title px-2">
          <div>{{property.Location}}</div>
          <!-- <DisplayPriceLegacy :symbolLast="false" :noCents="true" :sourceCurrency="property.currency" :displayCurrency="property.currency" :value="property.Price * 100"></DisplayPriceLegacy> -->
        </h6>
      </v-card-actions>
    </v-card>
  </div>
</template>
<script>
// import DisplayPriceLegacy from '@jsroot/shared/components/DisplayPriceLegacy'
export default {
  components: {
    // DisplayPriceLegacy,
  },
  props: ["property", "index", "noTransitionDelay"],
  data: () => ({
    // showTransitionWithDelay: false
  }),
  methods: {
    showEdit() {
      debugger
      // this.$store.commit('activateNewListing', { listing: listing })
      // this.listingModalVisible = true
    }
  },
  computed: {
    mainImageUrl() {
      let mainImage = this.property.image_urls[0] || ""
      // if (mainImage) {
      //   return mainImage.image.url
      // } else {
      //   return ""
      // }
      return mainImage
    },
    listingColor: function() {
      if (this.$store.getters.getActiveListing.uuid === this.property.uuid) {
        return "primary"
      } else {
        return ""
      }
    }
  },
  mounted: function() {}
}
</script>
<style scoped>
/* .info-text {
  font-size: 22px;
  color: darkgray;
}

.v-btn .v-btn__content .v-icon {
  color: darkgray;
} */

.summ-image {
  height: 200px;
  width: 100%;
  background-size: cover;
}

/* h4 {
  color: darkgray;
  text-transform: none;
  font: 600 20px Raleway, sans-serif;
  margin: 16px 8px;
}

.resales-row-title {
  height: 26px;
} */
</style>