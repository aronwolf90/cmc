import Vue from 'vue/dist/vue.common'
import Vuex from 'vuex'
import TurbolinksAdapter from './vue_turbolinks'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import Router from 'vue-router'
import Vuetify from 'vuetify'
import DaySpanVuetify from 'dayspan-vuetify'
import AsyncComputed from 'vue-async-computed'
import BootstrapVue from 'bootstrap-vue'

require('./polyfill')

Vue.use(BootstrapVue)
Vue.use(Vuex)
Vue.use(Vuetify)
Vue.use(Router)
Vue.use(AsyncComputed)
Vue.use(TurbolinksAdapter)
Vue.use(DaySpanVuetify, {
  methods: {
    getDefaultEventColor: () => '#1976d2'
  }
})
