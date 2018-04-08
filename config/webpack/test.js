const environment = require("./environment")

module.exports = environment.toWebpackConfig()
var nodeExternals = require("webpack-node-externals");

module.exports.externals = [nodeExternals({
  whitelist: [/.*bootstrap.*/, /.*vue-turbolinks.*/]
})]

module.exports.devtool = "inline-cheap-module-source-map"

module.exports.watchOptions = {
  poll: 1000
}
