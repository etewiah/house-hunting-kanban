import Vue from 'vue'
import Router from 'vue-router'
// import UsersPage from '@jsroot/shared/pages/UsersPage'
const UsersPage = () => import('@jsroot/shared/pages/UsersPage')
const HomePage = () => import('@pisocakeroot/pages/HomePage')
// const ContextPage = () => import('../../who-said-what-when/pages/ContextPage')
const ProjectHomePage = () => import('@jsroot/pisocake/pages/ProjectHomePage')
const EditListingPage = () => import('@jsroot/pisocake/pages/EditListingPage')

// import Meta from 'vue-meta'

Vue.use(Router)
// Vue.use(Meta)

const router = new Router({
  mode: 'history',
  // base: '/admin-vue/',
  // https://router.vuejs.org/en/advanced/scroll-behavior.html
  // scrollBehavior(to, from, savedPosition) {
  //   if (from.path !== to.path) {
  //     // always scroll to top when route (not query params) changes
  //     return { x: 0, y: 0 }
  //   }
  // },
  routes: [{
    path: '/',
    name: 'homePage',
    component: HomePage
  }, {
    path: '/p/:projectUuid',
    name: 'projectHomePage',
    component: ProjectHomePage
  }, {
    path: '/p/:projectUuid/:listingUuid',
    name: 'projectListingPage',
    component: ProjectHomePage
  }, {
    path: '/p/:projectUuid/edit/:listingId',
    name: 'editListingPage',
    component: EditListingPage
  }, {
  //   path: '/:locale(en|es|nl|fr|it)/f/:contentUuid',
  //   name: 'contextPage',
  //   component: ContextPage
  // }, {
  //   path: '/:locale(en|es|nl|fr|it)/f/:contentUuid/:viewToken',
  //   name: 'contextPageWithToken',
  //   component: ContextPage
  // }, {
    path: '/:locale(en|es|nl|fr|it)/f/:contentUuid/i/:inviteToken',
    name: 'inviteLanding',
    component: HomePage
  },
  {
    path: '/:locale(en|es|nl|fr|it)/users',
    component: UsersPage,
    name: 'users',
    redirect: {
      name: 'userSignIn'
    },
    children: [{
      path: 'sign_in',
      component: UsersPage,
      name: 'userSignIn',
      // }, {
      //   path: 'sign_up',
      //   component: UsersPage,
      //   name: 'userSignUp',
      // }, {
      //   path: 'edit',
      //   component: UsersPage,
      //   name: 'userEdit',
      // }, {
      //   path: 'password/new',
      //   component: UsersPage,
      //   name: 'userPasswordReset',
    },]
  },

  ]
})
// router.beforeEach((to, from, next) => {
//   // var isHomePage = (to.name === "landing") || (to.path === "/")
//   // if (isHomePage) {
//   //   // For "es" home url should always point to "/"
//   //   var localeUrls = {
//   //     en: "/en",
//   //     es: "/"
//   //   }
//   //   store.commit('setLocaleUrls', { result: localeUrls })
//   // } else {
//   //   store.commit('setLocaleUrls', { result: null })
//   // }
//   // // clear out 404 stat in case it has been set
//   // store.commit('set404', {is404: false})
//   // next()
// })
export default router