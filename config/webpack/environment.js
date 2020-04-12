const { environment } = require('@rails/webpacker')
const vue = require('./loaders/vue')

environment.loaders.append('vue', vue)
environment.config.set('resolve.alias.vue', 'vue/dist/vue.common')
module.exports = environment
