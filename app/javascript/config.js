import Vue from 'vue/dist/vue.common'
import Vuex from 'vuex'
import {
  Button,
  FormInput,
  Dropdown,
  FormTextarea,
  FormGroup,
  Form,
  FormSelect,
  Tooltip
} from 'bootstrap-vue/es/components'
import TurbolinksAdapter from './vue_turbolinks'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import Router from 'vue-router'
import Vuetify from 'vuetify'
import DaySpanVuetify from 'dayspan-vuetify'
import AsyncComputed from 'vue-async-computed'
import Modal from 'bootstrap-vue/es/components/modal'

require('./polyfill')

Vue.use(Vuex)
Vue.use(Vuetify)
Vue.use(Router)
Vue.use(AsyncComputed)
Vue.use(TurbolinksAdapter)
Vue.use(Button)
Vue.use(FormInput)
Vue.use(Dropdown)
Vue.use(Form)
Vue.use(FormTextarea)
Vue.use(FormGroup)
Vue.use(FormSelect)
Vue.use(Tooltip)
Vue.use(Modal)
Vue.use(DaySpanVuetify, {
  methods: {
    getDefaultEventColor: () => '#1976d2'
  }
})
