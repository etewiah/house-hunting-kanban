<template>
  <div v-scroll="onNavScroll" class="toolbar-cont">
    <div class="top_logo hidden-sm-and-down">
      <router-link :to="{name: homeRoute,params: { locale: 'en'}}">
      </router-link>
    </div>
    <v-toolbar :fixed="topNavFixed" class="hidden-sm-and-down fixable-bar pt-1 elevation-0">
      <v-menu bottom left>
        <v-btn icon slot="activator" @click.stop="drawer = !drawer" class="hidden-md-and-up" light>
          <v-icon>reorder</v-icon>
        </v-btn>
      </v-menu>
      <v-spacer></v-spacer>
      <v-toolbar-title>
      </v-toolbar-title>
      <v-toolbar-items class="malaga-toolbar">
        <template v-for="item in navLinks">
          <!-- <MainNavBtnMdUp :item="item" :navLinks="navLinks"></MainNavBtnMdUp> -->
        </template>
      </v-toolbar-items>
      <v-spacer></v-spacer>
    </v-toolbar>
    <v-toolbar class="hidden-md-and-up pt-1 elevation-0">
      <v-menu bottom left>
        <v-btn icon slot="activator" @click.stop="drawer = !drawer" class="" light>
          <v-icon>reorder</v-icon>
        </v-btn>
      </v-menu>
      <v-spacer></v-spacer>
      <v-toolbar-title>
        <div class="top_logo_sm pt-4">
          <router-link :to="{name: 'homePage',params: {}}">
          </router-link>
        </div>
      </v-toolbar-title>
      <v-spacer></v-spacer>
    </v-toolbar>
    <v-navigation-drawer class="hidden-md-and-up" v-model="drawer" fixed temporary>
      <v-list class="pa-1">
      </v-list>
    </v-navigation-drawer>
  </div>
</template>
<script>
// import MainNavBtnMdUp from '@jsroot/shared/components-nav/main-nav-level1/BtnMdUp'

export default {
  data() {
    return {
      drawer: false,
      topNavFixed: false
    }
  },
  components: {
    // MainNavBtnMdUp,
  },
  props: ["navLinks"],
  methods: {
    onNavScroll(e) {
      // Get the navbar
      var navbar = this.$el
      // .getElementsByClassName("toolbar-cont")[0]
      var pageTopOffset = window.pageYOffset

      // Get the offset position of the navbar
      var sticky = navbar.offsetTop + 90
      // console.log(pageTopOffset)
      // Add the sticky class to the navbar when you reach its scroll position. Remove "sticky" when you leave the scroll position
      if (pageTopOffset >= sticky) {
        this.topNavFixed = true
        // navbar.classList.add("sticky")
      } else {
        this.topNavFixed = false
        // navbar.classList.remove("sticky")
      }
    }
  },
  computed: {
    homeRoute() {
      return "homePage"
    },
  }
}
</script>
<style>
.application .theme--light.toolbar,
.theme--light .toolbar {
  background-color: transparent;
}

.fixable-bar {
  /* below is enough to stop search sliders seeping through fixed header*/
  z-index: 5;
  /*background-color: lightgray;*/
  /*background-image: url(/assets/malaga-silueta.jpg) !important;*/
  background-position: center bottom;
  background-repeat: no-repeat;
}

.fixable-bar {
  /*text-align: center;*/
}



/*.sticky {
  position: fixed;
  top: 0;
  width: 100%;
}


.sticky+.content {
  padding-top: 60px;
}*/

.top_logo,
.top_logo_sm {
  text-align: center;
  padding-top: 10px;
}

.top_logo_sm img {
  height: 50px;
}

.toolbar-cont {
  height: 150px;
  /*background-image: url(/assets/malaga-silueta.jpg) !important;*/
  background-position: center bottom;
  background-repeat: no-repeat;
}

.malaga-toolbar {
  height: 30px;
}

.my-flat {
  box-shadow: none !important;
  border-radius: 4px;
}


/*@media only screen and (max-width: 768px) {
*/

@media only screen and (max-width: 959px) {

  /*  .main-logo {
    height: 56px;
  }
*/
  .toolbar-cont {
    height: 75px;
    background-size: cover;
  }
}
</style>