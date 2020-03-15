import Vue from 'vue/dist/vue.common'
import Vuex from 'vuex'
import Store from '../store'

import IssuesBoard from '../board.vue'
import Issue from '../issue.vue'
import SharedIssueSection from '../shared_issue_section'
import WikiContent from '../wiki_content'
import WikiPage from '../wiki_page'
import ArchiveContent from '../archive_content'
import PersonalDashboardGraph from '../personal_dashboard_graph'
import ProjectSearchSelect from '../project_search_select'
import Calender from '../calender'
import Timepicker from '../components/timepicker'
import Datepicker from '../components/datepicker'
import Attendances from '../attendances'
import ProjectIndex from '../projects/index'
import UserIndex from '../users/index'
import ContactsIndex from '../contacts/index'
import Contact from '../contacts/show'
import ContactNew from '../contacts/new'
import ContactEdit from '../contacts/edit'
import DocumentNew from '../documents/new'
import DocumentEdit from '../documents/edit'
import AdminPayment from '../admin/payments/index.vue'
import UserNew from '../users/new'
import UserConfigurationEdit from '../users/configuration/edit.vue'
import NotificationBell from '../components/notification_bell'
import ContextEdit from '../admin/context/edit'
import Router from 'vue-router'
import IssueShow from 'issue/show'
import IssueNew from 'board/issues/new'
import IssueEdit from 'issue/edit'
import ProjectsLeftAside from 'components/projects-left-aside'
import ProjectsIndex from 'projects/index'
import ProjectStatusShow from 'project-statuses/show'
import ProjectStatusNew from 'project-statuses/new'
import ProjectStatusEdit from 'project-statuses/edit'
import ProjectNew from 'projects/new'
import ProjectEdit from 'projects/edit'

require('../config')

Vue.component('issues_board', IssuesBoard)
Vue.component('issue', Issue)
Vue.component('shared-issue-section', SharedIssueSection)
Vue.component('wiki-content', WikiContent)
Vue.component('wiki-page', WikiPage)
Vue.component('archive-content', ArchiveContent)
Vue.component('personal_dashboard_graph', PersonalDashboardGraph)
Vue.component('project-search-select', ProjectSearchSelect)
Vue.component('calender', Calender)
Vue.component('timepicker', Timepicker)
Vue.component('datepicker', Datepicker)
Vue.component('attendances', Attendances)
Vue.component('project-index', ProjectIndex)
Vue.component('user-index', UserIndex)
Vue.component('contacts-index', ContactsIndex)
Vue.component('contact', Contact)
Vue.component('contact-new', ContactNew)
Vue.component('contact-edit', ContactEdit)
Vue.component('document-new', DocumentNew)
Vue.component('document-edit', DocumentEdit)
Vue.component('payment', AdminPayment)
Vue.component('user-new', UserNew)
Vue.component('user-configuration-edit', UserConfigurationEdit)
Vue.component('notification-bell', NotificationBell)
Vue.component('context-edit', ContextEdit)
Vue.component('projects-left-aside', ProjectsLeftAside)

let store = new Vuex.Store(Store)
store.commit('setEndpoint', '/api/v1/')
store.commit('vue', Vue)

if (document.querySelector('meta[name="csrf-token"]')) {
  store.getters.axios.defaults.headers.common['X-CSRF-Token'] =
    document.querySelector('meta[name="csrf-token"]').getAttribute('content')
}

document.addEventListener('turbolinks:before-visit', () => {
  store.commit('clearCalledUrls')
})

document.addEventListener('turbolinks:load', () => {
  const router = new Router({
    mode: 'history',
    routes: [
      { path: '/', redirect: window.location.pathname },
      { path: '/administration/projects', component: ProjectsIndex },
      { path: '/administration/projects/new', component: ProjectNew },
      {
        path: '/administration/projects/:id/edit',
        component: ProjectEdit,
        props: true
      },
      {
        path: '/administration/project_statuses/new',
        component: ProjectStatusNew
      },
      {
        path: '/administration/project_statuses/:id',
        component: ProjectStatusShow,
        props: true
      },
      {
        path: '/administration/project_statuses/:id/edit',
        component: ProjectStatusEdit,
        props: true
      },
      { path: '/administration/board_lists', component: IssuesBoard },
      {
        path: '/administration/board_lists/:boardListId/issues/new',
        component: IssueNew,
        props: true
      },
      {
        path: '/administration/issues/:id',
        component: Issue,
        props: true,
        children: [
          { path: '', component: IssueShow },
          { path: 'edit', component: IssueEdit }
        ]
      }
    ]
  })
  var app = new Vue({ el: '#app', store, router }) /* eslint-disable-line no-unused-vars */
})
