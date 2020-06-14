<template>
  <v-app id="app" class="main-app-wrap" light>
    <v-app-bar app>
      <router-link class="no-text-dec" to="/">
        <v-toolbar-title class="headline text-uppercase">
          <span>House Hunting Kanban</span>
        </v-toolbar-title>
      </router-link>
      <v-spacer></v-spacer>
      <v-btn text href="/" class="hidden-sm-and-down" target="_blank">
        <span style="text-transform: capitalize;" class="mr-2">
        </span>
      </v-btn>
    </v-app-bar>
    <main>
      <v-content>
        <v-container fluid class="main-app-ct mt-0 pb-0 pl-0 pr-0 pt-0 elevation-0">
          <!-- <MainNav :navLinks="topNavLinks"></MainNav> -->
          <div class>
            <router-view></router-view>
          </div>
        </v-container>
      </v-content>
    </main>
    <v-navigation-drawer fixed temporary :right="right" v-model="rightDrawer" app>
      <v-list>
        <v-list-item @click.native="right = !right">
          <v-list-item-action>
            <v-icon light>compare_arrows</v-icon>
          </v-list-item-action>
          <v-list-item-title>Switch drawer (click me)</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-footer :fixed="false" class="pt-0" style="background: transparent;">
      <v-container :fluid="fluid" class="pa-0" light></v-container>
    </v-footer>
  </v-app>
</template>
<script>

export default {
  components: {
  },
  data: function() {
    return {
      fluid: true,
      clipped: false,
      drawer: false,
      fixed: false,
      items: [{ icon: "bubble_chart", title: "Inspire" }],
      miniVariant: false,
      right: true,
      rightDrawer: false
      // title: 'Vuetify.js',
    }
  },
  computed: {
    topNavLinks() {
      return []
    }
  }
}
</script>
<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>