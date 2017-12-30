import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex/dist/vuex.esm'
import { Button } from 'bootstrap-vue/es/components'
import { FormInput } from 'bootstrap-vue/es/components'
import { Modal } from 'bootstrap-vue/es/components'
import { Dropdown } from 'bootstrap-vue/es/components'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
//const bs = require('bootstrap.native/dist/bootstrap-native-v4');

import Store from '../store'

import IssuesBoard from '../board.vue'

Vue.use(Vuex)
Vue.use(TurbolinksAdapter)
Vue.use(VueResource)
Vue.use(Button)
Vue.use(FormInput)
Vue.use(Dropdown)

Vue.component('issues_board', IssuesBoard)
Vue.component('issues_board', IssuesBoard)

Vue.http.headers.common['X-CSRF-Token'] =
  document.querySelector('meta[name="csrf-token"]').getAttribute('content')

const store = new Vuex.Store(Store)

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({el: '#app', store})
})
