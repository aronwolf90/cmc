import Vue from 'vue/dist/vue.common'
import Vuex from 'vuex'
import Store from '../store'

require('../config')

let store = new Vuex.Store(Store)

Vue.http.headers.common['X-CSRF-Token'] =
  document.querySelector('meta[name="csrf-token"]').getAttribute('content')

document.addEventListener('turbolinks:before-visit', () => {
  store.commit('clear');
})

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({el: '#app', store})
})
