<template>
  <transition name="slide-in-left">
    <v-card v-if="showTrans" class="elevation-2">
      <v-card-title primary-title class="layout">
        <div class="headline ml-2">
        </div>
      </v-card-title>
      <v-card-text>
        <v-form v-model="formValid" ref="signInForm" lazy-validation @submit.prevent="onSignIn">
          <v-layout v-for="(field) in signInFields" :key="field.fieldName" row>
            <v-flex xs12 sm12 offset-sm0>
              <v-text-field prepend-icon="mdi-person" :autofocus="field.autofocus" :multi-line="field.multiLine" :required="field.required" :rules="field.validationRules" name="" :label="field.fieldName" v-model="signInData[field.fieldName]"></v-text-field>
            </v-flex>
          </v-layout>
          <v-text-field :type="hidePwd ? 'password' : 'text'" :append-icon="hidePwd ? 'visibility' : 'visibility_off'" :append-icon-cb="togglePwbVisibility" name="input-10-2" label="password" hint="At least 6 characters" min="6" v-model="signInData['password']" :rules="[v => !!v || 'Password is required']"></v-text-field>
          <p v-if="signInErrors.length">
            <template v-for="error in signInErrors">
              <v-alert outline color="error" icon="warning" :key="error" :value="true">
                {{error}}
              </v-alert>
            </template>
          </p>
          <!--           <p v-if="signInSuccess.length">
            <v-alert outline color="success" dismissible v-model="successModel">
              {{ signInSuccess }}
            </v-alert>
          </p> -->
          <v-flex xs12 sm12 offset-sm0>
            <template v-if="signInSending">
              <v-progress-linear :indeterminate="true"></v-progress-linear>
            </template>
            <v-btn class="accent" type="submit">
              Sign In
              <!-- {{$t("client_shared.core.signIn") }} -->
            </v-btn>
          </v-flex>
        </v-form>
      </v-card-text>
    </v-card>
  </transition>
</template>
<style>
@keyframes slide-in-left {
  0% {
    transform: scale(0);
    left: -1000px;
  }

  80% {
    transform: scale(0.9);
  }

  100% {
    left: 0;
    transform: scale(1);
  }
}

.slide-in-left-enter-active {
  animation: slide-in-left 0.5s;
}

.slide-in-left-leave-active {
  animation: slide-in-left 0.5s reverse;
}
</style>
<script>
export default {
  components: {},
  props: [],
  mounted: function() {
    var that = this
    setTimeout(function() {
      that.showTrans = true
    }, 500)
    // this.$store.dispatch('refreshCsrf')
  },
  data() {
    return {
      hidePwd: true,
      showTrans: false,
      successModel: true,
      // above only needed so success alert can be dismissed
      formValid: false,
      // validationErrors: [],
      signInFields: [{
        labelTextTKey: "client_shared.core.email",
        fieldName: "email",
        inputType: "text",
        required: true,
        validationRules: [
          v => !!v || 'E-mail is required',
          v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || 'E-mail must be valid'
        ]
        // }, {
        //   labelTextTKey: "client_shared.core.password",
        //   autofocus: false,
        //   fieldName: "password",
        //   inputType: "password",
        //   required: true,
        //   validationRules: [
        //     v => !!v || 'Password is required',
        //   ]
      }],
      signInData: {
        password: "",
        email: ""
      }
    }
  },
  computed: {
    signInSending() {
      return this.$store.state.User.signInSending
    },
    // signInSuccess() {
    //   return this.$store.state.User.signInSuccess
    // },
    signInErrors() {
      return this.$store.state.User.signInErrors
    },
  },
  methods: {
    togglePwbVisibility() {
      this.hidePwd = !this.hidePwd
    },
    onSignIn() {
      if (!this.formValid) {
        this.$refs.signInForm.validate()
        // in case nothing has been typed in, above will display error messages
        return
      }
      this.$store.dispatch('signIn', this.signInData)
    }

  }
}
</script>