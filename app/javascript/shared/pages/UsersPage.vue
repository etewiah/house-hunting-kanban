<template>
  <v-layout row wrap justify-center class="my-5">
    <v-flex xs12 sm4>
      <!--       <keep-alive>
      </keep-alive>
 https://vuejs.org/v2/guide/components-dynamic-async.html#keep-alive-with-Dynamic-Components-->
      <component :is="authComponent"></component>
    </v-flex>
  </v-layout>
</template>
<script>
import SignInForm from '@jsroot/shared/components-auth/SignInForm'
// import SignUpForm from '@jsroot/shared/components-auth/SignUpForm'
// import PasswordReset from '@jsroot/shared/components-auth/PasswordReset'
// import UserEdit from '@jsroot/shared/components-auth/UserEdit'
export default {
  metaInfo() {
    return {
      title: "Users",
    }
  },
  components: {
    SignInForm,
    // SignUpForm,
    // PasswordReset,
    // UserEdit
  },
  // mounted: function() {
  // },
  computed: {
    authComponent() {
      var authComponent = "SignInForm"
      if (this.$route.name === "userSignUp") {
        authComponent = "SignUpForm"
      }
      if (this.$route.name === "userPasswordReset") {
        authComponent = "PasswordReset"
      }
      if (this.$route.name === "userEdit") {
        authComponent = "UserEdit"
      }
      // let currentTabName = this.$route.params["tabName"]
      // // TODO: - use lodash for below:
      // let currentPropertyTab = this.findBy(this.$store.state.navigationStore.propertyTabs, currentTabName, 'tabValue')
      return authComponent
    },
    // currentUser() {
    //   return this.$store.state.currentUser || {}
    // }
  },
}
</script>
<style scoped>
</style>