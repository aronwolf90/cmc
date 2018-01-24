const environment = require('./environment')

module.exports = environment.toWebpackConfig()

module.exports.externals = [require('webpack-node-externals')()]
// use inline source map so that it works with mocha-webpack
module.exports.devtool = 'inline-cheap-module-source-map'
