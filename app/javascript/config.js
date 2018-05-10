import Vue from 'vue/dist/vue.common'
import Vuex from 'vuex'
import {
  Button,
  FormInput,
  Dropdown,
  FormTextarea,
  FormGroup,
  Form,
  FormSelect
} from 'bootstrap-vue/es/components'
import TurbolinksAdapter from './vue_turbolinks'
import VueResource from 'vue-resource'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import Router from 'vue-router'

require('./polyfill')

Vue.use(Vuex)
Vue.use(Router)
Vue.use(TurbolinksAdapter)
Vue.use(VueResource)
Vue.use(Button)
Vue.use(FormInput)
Vue.use(Dropdown)
Vue.use(Form)
Vue.use(FormTextarea)
Vue.use(FormGroup)
Vue.use(FormSelect)
