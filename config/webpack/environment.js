const { environment } = require('@rails/webpacker')
// const { config } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const VuetifyLoaderPlugin = require('vuetify-loader/lib/plugin')
const vue = require('./loaders/vue')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')

// https://github.com/rails/webpacker/issues/2235
// We need to remove the webpacker preconfigured CSS loader as it conflicts with our own SASS config
// environment.loaders.delete('css')
environment.loaders.delete('sass')
// environment.loaders.delete('scss')

environment.loaders.append('sass', {
  test: /\.sass$/,
  use: [
    environment.extract_css === false
      ? 'vue-style-loader'
      : MiniCssExtractPlugin.loader,
    {
      loader: 'css-loader',
      options: {
        sourceMap: true,
        importLoaders: 2
      }
    },
    {
      loader: 'sass-loader',
      options: {
        sourceMap: true,
        implementation: require('sass'),
        sassOptions: {
          fiber: require('fibers'),
        },
        // data: `@import "app/javascript/manager/styles/main.scss"`,
        // indentedSyntax: true
      }
    }
  ]
})

environment.loaders.append('scss', {
  test: /\.scss$/,
  use: [
    environment.extract_css === false
      ? 'vue-style-loader'
      : MiniCssExtractPlugin.loader,
    {
      loader: 'css-loader',
      options: {
        sourceMap: true,
        importLoaders: 2
      }
    },
    {
      loader: 'postcss-loader',
      options: {
        sourceMap: true
      }
    },
    {
      loader: 'sass-loader',
      options: {
        sourceMap: true,
        implementation: require('sass'),
        // fiber: require('fibers'),
        sassOptions: {
          fiber: require('fibers'),
        },
        // data: `@import "app/javascript/manager/styles/main.scss";`
      }
    }
  ]
})

environment.plugins.append('MiniCssExtractPlugin', new MiniCssExtractPlugin({
  filename: 'css/[name]-[contenthash:8].css',
  chunkFilename: 'css/[name]-[contenthash:8].chunk.css'
}))
// environment.plugins.append('VueLoaderPlugin', new VueLoaderPlugin())
environment.plugins.prepend('VuetifyLoaderPlugin', new VuetifyLoaderPlugin())


environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)

const customConfig = require('./custom')
// Merge custom config
environment.config.merge(customConfig)

// // https://github.com/rails/webpacker/issues/790
// // allows me to better understand my vue file sizes:
// const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
// environment.plugins.append('BundleAnalyzer',   new BundleAnalyzerPlugin({
//     analyzerMode: 'disabled',
//     generateStatsFile: true,
//     statsOptions: { source: false }
//   }))

module.exports = environment
