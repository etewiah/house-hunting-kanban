const path = require('path')

// Feb 2019
// https://github.com/rails/webpacker/issues/1063
// after creating this file, need to refer to it from environment.js
module.exports = {
  resolve: {
    alias: {
      // Nov 2018 - below might fix warning about vue being run in dev mode:
      // vue: 'vue/dist/vue.min.js',
      // '@components': path.resolve(__dirname, '..', '..', 'app/javascript/theme-vienna/components'),
      '@jsroot': path.resolve(__dirname, '..', '..', 'app/javascript'),
      // '@wswwroot': path.resolve(__dirname, '..', '..', 'app/javascript/who-said-what-when'),
      '@pisocakeroot': path.resolve(__dirname, '..', '..', 'app/javascript/pisocake'),
      // '@tsroot': path.resolve(__dirname, '..', '..', 'app/javascript/timestamp'),
      // use tilde when refering to above from styles:
      // https://github.com/webpack-contrib/css-loader/issues/256
    }
  }
}

// const { environment } = require('@rails/webpacker')
// const vue =  require('./loaders/vue')

// environment.loaders.append('vue', vue)
// module.exports = environment
