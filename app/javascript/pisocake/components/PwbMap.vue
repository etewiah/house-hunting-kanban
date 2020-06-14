<template>
  <gmap-map ref="gmapRef" style="min-height: 600px;" :zoom="15" :center="center">
    <gmap-info-window
      ref="infwin"
      :options="infoOptions"
      :position="infoWindowPos"
      :opened="infoWinOpen"
      @closeclick="infoWinOpen=false"
    ></gmap-info-window>
    <gmap-marker
      v-for="(m,i) in mapMarkers"
      :key="m.id"
      :position="m.position"
      @mouseover="toggleInfoWindow(m,i)"
      @mouseout="statusText = null"
      :clickable="true"
      :draggable="false"
      @click="toggleInfoWindow(m,i)"
    ></gmap-marker>
  </gmap-map>
</template>
<script>
export default {
  props: ["mapMarkers", "noInfoWindow", "fallbackCenter"],
  data: function() {
    return {
      newMarkers: [],
      useNewMarkers: false,
      infoContent: "",
      statusText: "",
      // center is a required prop
      center: { lat: 10, lng: 10 },
      infoWindowPos: {
        lat: 0,
        lng: 0
      },
      // TODO: - allow setting of defaults for above
      // from server
      infoWinOpen: false,
      currentMindex: null,
      infoOptions: {
        content: "hey",
        pixelOffset: {
          width: 0,
          height: -35
        }
      }
    }
  },
  // created() {
  // },
  mounted: function() {
    // below needed for display of currentAgency location
    // Will need to check to ensure that it does not impact
    // search results map
    if (this.mapMarkers[0] && this.mapMarkers[0].position.lat) {
      let lat = this.mapMarkers[0].position.lat
      let lng = this.mapMarkers[0].position.lng
      this.center = { lat: lat, lng: lng }
    }
    // if ((this.center.lat === 10) && (this.center.lng === 10)) {
    //   this doesn't work as fallbackCenter value may not be ready at mount
    //   this.center = this.fallbackCenter || { lat: 10, lng: 20 }
    // }
  },
  methods: {
    resizeMap: function() {
      var that = this
      this.$refs.gmapRef.$mapPromise.then(function() {
        if (that.mapMarkers.length === 1) {
          let lat = that.mapMarkers[0].position.lat
          let lng = that.mapMarkers[0].position.lng
          let center = { lat: lat, lng: lng }
          that.center = center
          that.$refs.gmapRef.$mapObject.setCenter(center)
          that.$refs.gmapRef.$mapObject.setZoom(15)
          // if (map.getZoom() > 16) map.setZoom(16);
        }
        if (that.mapMarkers.length > 1) {
          // let google = {}
          var bounds = new google.maps.LatLngBounds()
          that.mapMarkers.forEach(function(mapker) {
            bounds.extend(mapker.position)
          })
          // for (let m of that.mapMarkers) {
          //   bounds.extend(m.position)
          // }

          // that.$refs.gmapRef.$mapObject.fitBounds(bounds)
          // could also call fitBounds on raw mapObject like above
          that.$refs.gmapRef.fitBounds(bounds)
          // where markers are too close together, I need below
          // to ensure they are not too zoomed in
          // that.$refs.gmapRef.$mapObject.setOptions({ maxZoom: that.$refs.gmapRef.$mapObject.getZoom() })
        }
      })
    },
    // resetMarkers: function(newMarkers) {
    //   this.newMarkers = newMarkers
    //   this.useNewMarkers = true
    // },
    toggleInfoWindow: function(marker, index) {
      if (this.noInfoWindow) {
        return false
      }
      this.infoWindowPos = marker.position
      var display_price_html = ""
      if (marker.display_price) {
        display_price_html =
          '<div class="iw-subTitle">' + marker.display_price + "</div>"
      }
      var image_html = ""
      if (marker.image_url) {
        image_html = '<img src="' + marker.image_url + '" alt="" width="225">'
      }

      var infoWindowContent =
        '<div class="iw-container">' +
        '<a href="' +
        marker.show_url +
        '" class="iw-href">' +
        '<div class="iw-content">' +
        display_price_html +
        image_html +
        "</div>" +
        '<div class="iw-title primary--text">' +
        marker.title +
        "</div>" +
        "</a>" +
        "</div>"

      this.infoOptions.content = infoWindowContent
      // check if its the same marker that was selected if yes toggle
      if (this.currentMindex === index) {
        this.infoWinOpen = !this.infoWinOpen
      } else {
        // if different marker set infowindow to open and reset current marker index
        this.infoWinOpen = true
        this.currentMindex = index
      }
    }
  },
  watch: {
    fallbackCenter(fallbackCenter) {
      if (this.center.lat === 10 && this.center.lng === 10) {
        this.center = fallbackCenter || { lat: 10, lng: 20 }
      }
    },
    mapMarkers(mapMarkers) {
      this.resizeMap()
    }
  },
  computed: {
    // don't want center when resizing map to fitbounds
    // center: function() {
    //   if (this.mapMarkers[0] && this.mapMarkers[0].position.lat) {
    //     let lat = this.mapMarkers[0].position.lat
    //     let lng = this.mapMarkers[0].position.lng
    //     return { lat: lat, lng: lng }
    //   } else {
    //     let latLng = { lat: 10, lng: 10 }
    //     return latLng
    //   }
    //   // `this` points to the vm instance
    // }
  }
}
</script>
<style>
.iw-container {
  max-width: 220px;
  overflow: hidden;
  margin-top: 6%;
}

.iw-href {
  text-decoration: none;
}

.iw-title {
  font-size: 16px;
  font: 400 20px Raleway, sans-serif;
}

.vue-map-container .vue-map {
  left: 33%;
  top: 28px;
  /* position: fixed !important; */
  /* jan 2020 - had to replace above with below */
  position: absolute !important;
}
/*above to fix map to right side of screen*/
@media only screen and (max-width: 959px) {
  /*TODO - fix this - currently map disappears on mobiles*/
  .vue-map-container .vue-map {
    left: 0 !important;
    height: 100%;
    position: absolute !important;
  }
}
</style>