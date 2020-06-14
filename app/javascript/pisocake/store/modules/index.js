/**
https://dev.to/localeai/architecting-vuex-store-for-large-scale-vue-js-applications-4f1f
 * Automatically imports all the modules and exports as a single module object
 */
const requireModule = require.context('.', false, /\.store\.js$/);
const modules = {};

requireModule.keys().forEach(filename => {

  // create the module name from fileName
  // remove the store.js extension and capitalize
  const moduleName = filename
    .replace(/(\.\/|\.store\.js)/g, '')
    .replace(/^\w/, c => c.toUpperCase())

  modules[moduleName] = requireModule(filename).default || requireModule(filename);
});

export default modules;

// // https://vuex.vuejs.org/en/modules.html
// const requireModule = require.context('.', true, /\.js$/)
// const modules = {}

// requireModule.keys().forEach(fileName => {
//   if (fileName === './index.js') return

//   // Replace ./ and .js
//   const path = fileName.replace(/(\.\/|\.js)/g, '')
//   const [moduleName, imported] = path.split('/')

//   if (!modules[moduleName]) {
//     modules[moduleName] = {
//       namespaced: false
//     }
//   }

//   modules[moduleName][imported] = requireModule(fileName).default
// })

// export default modules
