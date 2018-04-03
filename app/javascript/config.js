import Vue from 'vue/dist/vue.common'
import Vuex from 'vuex'
import {
  Button,
  FormInput,
  Dropdown,
  FormTextarea,
  FormGroup,
  Form
} from 'bootstrap-vue/es/components'
import TurbolinksAdapter from './vue_turbolinks'
import VueResource from 'vue-resource'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import IssuesBoard from './board.vue'
import Issue from './issue.vue'
import SharedIssueSection from './shared_issue_section'
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

Vue.component('issues_board', IssuesBoard)
Vue.component('issue', Issue)
Vue.component('shared-issue-section', SharedIssueSection)
