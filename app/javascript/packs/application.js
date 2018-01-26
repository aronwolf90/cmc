import Vue from 'vue/dist/vue.common'
import Vuex from 'vuex'
import Store from '../store'

require('../config')

document.addEventListener('turbolinks:before-visit', () => {
  store.commit('clear', storeState);
})

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({el: '#app', store})
})
