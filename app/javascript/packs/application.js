import Vue from 'vue/dist/vue.common'
import Vuex from 'vuex'
import Store from '../store'

import IssuesBoard from '../board.vue'
import Issue from '../issue.vue'
import SharedIssueSection from '../shared_issue_section'
import WikiContent from '../wiki_content'
import WikiPage from '../wiki_page'
import ArchiveContent from '../archive_content'
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
import ProjectShow from 'projects/show'
import ProjectDefault from 'projects/default'
import ProjectBoardListNew from 'project-statuses/project-board-lists/new'
import ProjectBoardListEdit from 'project-board-lists/edit'
import MarkdownEditor from 'markdown_editor'
import ProjectsDetailLeftAside from 'components/projects-detail-left-aside'
import ProjectsDocumentsIndex from 'projects/documents/index'
import ProjectsDocumentsNew from 'projects/documents/new'
import ProjectsDocumentsEdit from 'projects/documents/edit'
import LeftAside from 'components/left-aside'
import RailsPage from 'components/rails-page'
import MenuItem from 'components/menu-item'
import Asides from 'components/asides'
import BtnSubmit from 'components/btn-submit'
import ProjectTickets from 'projects/tickets'
import BoardListNew from 'board_lists/new'
import BoardListEdit from 'board_lists/edit'
import 'vue-select/dist/vue-select.css'
import LoadScript from 'vue-plugin-load-script'
import VueAnalytics from 'vue-analytics'
import * as Sentry from '@sentry/browser'

require('../config')

Vue.use(LoadScript)

Vue.component('issues_board', IssuesBoard)
Vue.component('issue', Issue)
Vue.component('shared-issue-section', SharedIssueSection)
Vue.component('wiki-content', WikiContent)
Vue.component('wiki-page', WikiPage)
Vue.component('archive-content', ArchiveContent)
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
Vue.component('user-configuration-edit', UserConfigurationEdit)
Vue.component('notification-bell', NotificationBell)
Vue.component('context-edit', ContextEdit)
Vue.component('projects-left-aside', ProjectsLeftAside)
Vue.component('markdown-editor', MarkdownEditor)
Vue.component('projects-detail-left-aside', ProjectsDetailLeftAside)
Vue.component('left-aside', LeftAside)
Vue.component('menu-item', MenuItem)
Vue.component('asides', Asides)
Vue.component('btn-submit', BtnSubmit)

let store = new Vuex.Store(Store)
store.commit('setEndpoint', '/api/v1/')
store.commit('vue', Vue)
window.store = store

if (document.querySelector('meta[name="csrf-token"]')) {
  store.getters.axios.defaults.headers.common['X-CSRF-Token'] =
    document.querySelector('meta[name="csrf-token"]').getAttribute('content')
}

window.Sentry = Sentry
if (window.sentry_dsn) {
  window.Sentry.init({ dsn: window.sentry_dsn })
}

document.addEventListener('turbolinks:before-visit', () => {
  store.commit('clearCalledUrls')
})

document.addEventListener('turbolinks:load', () => {
  const router = new Router({
    mode: 'history',
    routes: [
      {
        path: '/',
        redirect: window.location.pathname,
        meta: { aside: 'global' }
      },
      {
        path: '/administration',
        component: RailsPage,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/board_lists',
        component: IssuesBoard,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/board_lists/new',
        component: BoardListNew,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/board_lists/:id/edit',
        component: BoardListEdit,
        props: true,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/calender',
        component: Calender,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/attendances',
        component: Attendances,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/projects',
        component: ProjectsIndex,
        meta: { aside: 'projects' }
      },
      {
        path: '/administration/projects/new',
        component: ProjectNew,
        meta: { aside: 'projects' }
      },
      {
        path: '/administration/projects/:id',
        component: ProjectShow,
        props: true,
        meta: { aside: 'projects-detail' },
        children: [
          {
            path: '',
            component: ProjectDefault,
            props: true,
            meta: { aside: 'projects-detail' }
          },
          {
            path: 'edit',
            component: ProjectEdit,
            props: true,
            meta: { aside: 'projects-detail' }
          }
        ]
      },
      {
        path: '/administration/projects/:id/records',
        component: RailsPage,
        props: true,
        meta: { aside: 'projects-detail' }
      },
      {
        path: '/administration/projects/:id/records/new',
        component: RailsPage,
        props: true,
        meta: { aside: 'projects-detail' }
      },
      {
        path: '/administration/projects/:projectId/documents',
        component: ProjectsDocumentsIndex,
        props: true,
        meta: { aside: 'projects-detail' }
      },
      {
        path: '/administration/projects/:projectId/documents/new',
        component: ProjectsDocumentsNew,
        props: true,
        meta: { aside: 'projects-detail' }
      },
      {
        path: '/administration/projects/:projectId/documents/:id/edit',
        component: ProjectsDocumentsEdit,
        props: true,
        meta: { aside: 'projects-detail' }
      },
      {
        path: '/administration/projects/:projectId/board_lists',
        component: ProjectTickets,
        props: true,
        meta: { aside: 'projects-detail' }
      },
      {
        path: '/administration/projects/:projectId/board_lists/new',
        component: BoardListNew,
        meta: { aside: 'projects-detail' }
      },
      {
        path: '/administration/projects/:projectId/board_lists/:boardListId/issues/new',
        component: IssueNew,
        props: true,
        meta: { aside: 'projects-detail' }
      },
      {
        path: '/administration/projects/:projectId/board_lists/:id/edit',
        component: BoardListEdit,
        props: true,
        meta: { aside: 'projects-detail' }
      },
      {
        path: '/administration/projects/:projectId/issues/:id',
        component: Issue,
        props: true,
        children: [
          {
            path: '',
            component: IssueShow,
            meta: { aside: 'projects-detail' }
          },
          {
            path: 'edit',
            component: IssueEdit,
            meta: { aside: 'projects-detail' }
          }
        ]
      },
      {
        path: '/administration/records',
        component: RailsPage,
        props: true,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/records/new',
        component: RailsPage,
        props: true,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/records/:id/edit',
        component: RailsPage,
        props: true,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/project_statuses/new',
        component: ProjectStatusNew,
        meta: { aside: 'projects' }
      },
      {
        path: '/administration/project_statuses/:id',
        component: ProjectStatusShow,
        props: true,
        meta: { aside: 'projects' }
      },
      {
        path: '/administration/project_statuses/:id/edit',
        component: ProjectStatusEdit,
        props: true,
        meta: { aside: 'projects' }
      },
      {
        path: '/administration/project_statuses/:projectStatusId/project_board_lists/new',
        component: ProjectBoardListNew,
        props: true,
        meta: { aside: 'projects' }
      },
      {
        path: '/administration/project_board_lists/:id/edit',
        component: ProjectBoardListEdit,
        props: true,
        meta: { aside: 'projects' }
      },
      {
        path: '/administration/board_lists/',
        component: IssuesBoard,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/board_lists/new',
        component: BoardListNew,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/board_lists/:id/edit',
        component: RailsPage,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/board_lists/:boardListId/issues/new',
        component: IssueNew,
        props: true,
        meta: { aside: 'global' }
      },
      {
        path: '/administration/issues/:id',
        component: Issue,
        props: true,
        children: [
          {
            path: '',
            component: IssueShow,
            meta: { aside: 'global' }
          },
          {
            path: 'edit',
            component: IssueEdit,
            meta: { aside: 'global' }
          }
        ]
      },
      {
        path: '/administration/wiki',
        component: WikiContent,
        props: true,
        meta: { aside: 'wiki' }
      },
      {
        path: '/administration/wiki/pages/new',
        component: RailsPage,
        props: true,
        meta: { aside: 'wiki' }
      },
      {
        path: '/administration/wiki/pages/:wikiPageId',
        component: WikiPage,
        props: true,
        meta: { aside: 'wiki' }
      },
      {
        path: '/administration/wiki/categories/new',
        component: RailsPage,
        props: true,
        meta: { aside: 'wiki' }
      },
      {
        path: '/administration/archive',
        component: ArchiveContent,
        props: true,
        meta: { aside: 'archive' }
      },
      {
        path: '/administration/archive/folders/new',
        component: RailsPage,
        props: true,
        meta: { aside: 'archive' }
      },
      {
        path: '/administration/archive/folders/:id/edit',
        component: RailsPage,
        props: true,
        meta: { aside: 'archive' }
      },
      {
        path: '/administration/archive/documents/new',
        component: DocumentNew,
        props: true,
        meta: { aside: 'archive' }
      },
      {
        path: '/administration/archive/documents/:documentId/edit',
        component: DocumentEdit,
        props: true,
        meta: { aside: 'archive' }
      },
      {
        path: '/administration/users',
        component: UserIndex,
        props: true,
        meta: { aside: 'users' }
      },
      {
        path: '/administration/users/new',
        component: UserNew,
        props: true,
        meta: { aside: 'users' }
      },
      {
        path: '/administration/contacts',
        component: ContactsIndex,
        props: true,
        meta: { aside: 'contacts' }
      },
      {
        path: '/administration/contacts/new',
        component: ContactNew,
        props: true,
        meta: { aside: 'contacts' }
      },
      {
        path: '/administration/contacts/:contactId',
        component: Contact,
        props: true,
        meta: { aside: 'contacts' }
      },
      {
        path: '/administration/contacts/:contactId/edit',
        component: ContactEdit,
        props: true,
        meta: { aside: 'contacts' }
      },
      {
        path: '/administration/admin/context',
        component: ContextEdit,
        props: true,
        meta: { aside: 'admin' }
      },
      {
        path: '/administration/admin/payments',
        component: AdminPayment,
        props: true,
        meta: { aside: 'admin' }
      },
      {
        path: '/administration/users/:id',
        component: RailsPage,
        props: true,
        meta: { aside: 'user-detail' }
      },
      {
        path: '/administration/users/:userId/configuration/edit',
        component: UserConfigurationEdit,
        props: true,
        meta: { aside: 'user-detail' }
      },
      {
        path: '/administration/users/:id/records',
        component: RailsPage,
        props: true,
        meta: { aside: 'user-detail' }
      }
    ]
  })

  router.beforeEach((to, from, next) => {
    store.commit('clearCalledUrls')
    store.commit('setAside', to.meta.aside)
    if (to.path !== from.path && from.path !== '/') {
      store.commit('setPrevPath', from.path)
    }
    toggleAsideExpanded(false) /* eslint-disable-line no-undef */
    $('.navbar-collapse').collapse('hide') /* eslint-disable-line no-undef */
    next()
  })

  if (window.googleAnalyticsId) {
    Vue.use(VueAnalytics, {
      id: window.googleAnalyticsId,
      router
    })
  }

  var app = new Vue({ el: '#app', store, router }) /* eslint-disable-line no-unused-vars */
})
