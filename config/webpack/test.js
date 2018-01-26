const environment = require('./environment')

module.exports = environment.toWebpackConfig()

var nodeExternals = require('webpack-node-externals');

module.exports.externals = [nodeExternals({
  whitelist: [/.*bootstrap.*/, /.*vue-turbolinks.*/]
})]
