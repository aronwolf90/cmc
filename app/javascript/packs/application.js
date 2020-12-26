import 'stylesheets/devise.sass'

import Vue from 'vue/dist/vue.common'
import Vuex from 'vuex'
import Store from '../store'

import WikiPageShow from 'wiki_page/show'
import ProjectDefault from 'projects/default'
import ProjectsEdit from 'pages/projects/_id/edit'
import SharedIssueSection from 'components/shared-issue-section'
import ProjectSearchSelect from '../project_search_select'
import Timepicker from '../components/timepicker'
import Datepicker from '../components/datepicker'
import NotificationBell from '../components/notification_bell'
import Router from 'vue-router'
import IssueShow from 'issue/show'
import IssueEdit from 'issue/edit'
import ProjectsLeftAside from 'components/projects-left-aside'
import MarkdownEditor from 'markdown_editor'
import ProjectsDetailLeftAside from 'components/projects-detail-left-aside'
import LeftAside from 'components/left-aside'
import RailsPage from 'components/rails-page'
import MenuItem from 'components/menu-item'
import Asides from 'components/asides'
import BtnSubmit from 'components/btn-submit'
import 'vue-select/dist/vue-select.css'
import LoadScript from 'vue-plugin-load-script'
import VueAnalytics from 'vue-analytics'
import * as Sentry from '@sentry/browser'
import vSelect from 'vue-select'
import jQuery from 'jquery'
import 'bootstrap'
import 'eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css'
import 'font-awesome/css/font-awesome.min.css'
import 'stylesheets/administration.sass'
import WikiPageEdit from 'wiki_page/edit'

const $ = jQuery
window.jQuery = jQuery
window.$ = $

require('jquery-ujs')
require.context('../images', true)

require('../config')
Vue.use(LoadScript)

Vue.component('shared-issue-section', SharedIssueSection)
Vue.component('project-search-select', ProjectSearchSelect)
Vue.component('timepicker', Timepicker)
Vue.component('datepicker', Datepicker)
Vue.component('notification-bell', NotificationBell)
Vue.component('projects-left-aside', ProjectsLeftAside)
Vue.component('markdown-editor', MarkdownEditor)
Vue.component('projects-detail-left-aside', ProjectsDetailLeftAside)
Vue.component('left-aside', LeftAside)
Vue.component('menu-item', MenuItem)
Vue.component('asides', Asides)
Vue.component('btn-submit', BtnSubmit)
Vue.component('v-select', vSelect)

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
      component: () => import('pages/board-lists/index'),
      meta: { aside: 'global' }
    },
    {
      path: '/administration/board_lists/new',
      component: () => import('pages/board-lists/new'),
      meta: { aside: 'global' }
    },
    {
      path: '/administration/board_lists/:id/edit',
      component: () => import('pages/board-lists/edit'),
      props: true,
      meta: { aside: 'global' }
    },
    {
      path: '/administration/calendar',
      component: () => import('pages/calendars/index'),
      meta: { aside: 'global' }
    },
    {
      path: '/administration/attendances',
      component: () => import('pages/attendances/index'),
      meta: { aside: 'global' }
    },
    {
      path: '/administration/projects',
      component: () => import('pages/projects/index'),
      meta: { aside: 'projects' }
    },
    {
      path: '/administration/projects/new',
      component: () => import('pages/projects/new'),
      meta: { aside: 'projects' }
    },
    {
      path: '/administration/projects/:id',
      component: () => import('pages/projects/_id'),
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
          component: ProjectsEdit,
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
      path: '/administration/projects/:projectId/documents',
      component: () => import('pages/projects/_id/documents/index'),
      props: true,
      meta: { aside: 'projects-detail' }
    },
    {
      path: '/administration/projects/:projectId/documents/new',
      component: () => import('pages/projects/_id/documents/new'),
      props: true,
      meta: { aside: 'projects-detail' }
    },
    {
      path: '/administration/projects/:projectId/documents/:id/edit',
      component: () => import('pages/projects/_id/documents/_id/edit'),
      props: true,
      meta: { aside: 'projects-detail' }
    },
    {
      path: '/administration/projects/:projectId/board_lists',
      component: () => import('pages/projects/_id/board-lists'),
      props: true,
      meta: { aside: 'projects-detail' }
    },
    {
      path: '/administration/projects/:projectId/board_lists/new',
      component: () => import('pages/board-lists/new'),
      meta: { aside: 'projects-detail' }
    },
    {
      path: '/administration/projects/:projectId/board_lists/:boardListId/issues/new',
      component: () => import('pages/board-lists/issues/new'),
      props: true,
      meta: { aside: 'projects-detail' }
    },
    {
      path: '/administration/projects/:projectId/board_lists/:id/edit',
      component: () => import('pages/board-lists/edit'),
      props: true,
      meta: { aside: 'projects-detail' }
    },
    {
      path: '/administration/projects/:projectId/issues/:id',
      component: () => import('pages/issues/_id'),
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
      component: () => import('pages/records/index'),
      props: true,
      meta: { aside: 'global' }
    },
    {
      path: '/administration/records/new',
      component: () => import('pages/records/new'),
      props: true,
      meta: { aside: 'global' }
    },
    {
      path: '/administration/records/:id/edit',
      component: () => import('pages/records/edit'),
      props: true,
      meta: { aside: 'global' }
    },
    {
      path: '/administration/project_statuses/new',
      component: () => import('pages/project-statuses/new'),
      meta: { aside: 'projects' }
    },
    {
      path: '/administration/project_statuses/:id',
      component: () => import('pages/project-statuses/_id'),
      props: true,
      meta: { aside: 'projects' }
    },
    {
      path: '/administration/project_statuses/:id/edit',
      component: () => import('pages/project-statuses/_id/edit'),
      props: true,
      meta: { aside: 'projects' }
    },
    {
      path: '/administration/project_statuses/:projectStatusId/project_board_lists/new',
      component: () => import('pages/project-statuses/_id/project-board-lists/new'),
      props: true,
      meta: { aside: 'projects' }
    },
    {
      path: '/administration/project_board_lists/:id/edit',
      component: () => import('pages/project-board-lists/_id/edit'),
      props: true,
      meta: { aside: 'projects' }
    },
    {
      path: '/administration/board_lists/:id/edit',
      component: RailsPage,
      meta: { aside: 'global' }
    },
    {
      path: '/administration/board_lists/:boardListId/issues/new',
      component: () => import('pages/board-lists/issues/new'),
      props: true,
      meta: { aside: 'global' }
    },
    {
      path: '/administration/issues/:id',
      component: () => import('pages/issues/_id'),
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
      component: () => import('pages/wiki/index'),
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
      component: () => import('pages/wiki/pages/_id'),
      props: true,
      meta: { aside: 'wiki' },
      children: [
        {
          path: '',
          component: WikiPageShow,
          meta: { aside: 'global' }
        },
        {
          path: 'edit',
          component: WikiPageEdit,
          meta: { aside: 'global' }
        }
      ]
    },
    {
      path: '/administration/wiki/categories/new',
      component: RailsPage,
      props: true,
      meta: { aside: 'wiki' }
    },
    {
      path: '/administration/wiki/categories/:id/edit',
      component: RailsPage,
      props: true,
      meta: { aside: 'wiki' }
    },
    {
      path: '/administration/archive',
      component: () => import('pages/archive/index'),
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
      component: () => import('pages/archive/documents/new'),
      props: true,
      meta: { aside: 'archive' }
    },
    {
      path: '/administration/archive/documents/:documentId/edit',
      component: () => import('pages/archive/documents/_id/edit'),
      props: true,
      meta: { aside: 'archive' }
    },
    {
      path: '/administration/users',
      component: () => import('pages/users/index'),
      props: true,
      meta: { aside: 'users' }
    },
    {
      path: '/administration/users/new',
      component: () => import('pages/users/new'),
      props: true,
      meta: { aside: 'users' }
    },
    {
      path: '/administration/contacts',
      component: () => import('pages/contacts/index'),
      props: true,
      meta: { aside: 'contacts' }
    },
    {
      path: '/administration/contacts/new',
      component: () => import('pages/contacts/new'),
      props: true,
      meta: { aside: 'contacts' }
    },
    {
      path: '/administration/contacts/:contactId',
      component: () => import('pages/contacts/_id'),
      props: true,
      meta: { aside: 'contacts' }
    },
    {
      path: '/administration/contacts/:contactId/edit',
      component: () => import('pages/contacts/_id/edit'),
      props: true,
      meta: { aside: 'contacts' }
    },
    {
      path: '/administration/admin/context',
      component: () => import('pages/admin/context/edit'),
      props: true,
      meta: { aside: 'admin' }
    },
    {
      path: '/administration/admin/payments',
      component: () => import('pages/admin/payments/index'),
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
      component: () => import('pages/users/configuration/edit'),
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

document.addEventListener('DOMContentLoaded', () => {
  if (window.googleAnalyticsId) {
    Vue.use(VueAnalytics, {
      id: window.googleAnalyticsId,
      router
    })
  }

  window.app = new Vue({ el: '#app', store, router }) /* eslint-disable-line no-unused-vars */
  window.jqueryFuncs()
})

var toggleAsideExpanded = function (status) {
  const sideMenu = document.getElementsByClassName('side-menu')
  if (status === undefined) {
    sideMenu[0].classList.toggle('expanded')
    window.leftAsideExpanded = !window.leftAsideExpanded
    document.querySelector('#side-toggle-btn > .fa').classList.toggle('fa-angle-right')
    document.querySelector('#side-toggle-btn > .fa').classList.toggle('fa-angle-left')
  } else if (status === false) {
    sideMenu[0].classList.remove('expanded')
    window.leftAsideExpanded = false
    document.querySelector('#side-toggle-btn > .fa').classList.remove('fa-angle-right')
    document.querySelector('#side-toggle-btn > .fa').classList.remove('fa-angle-left')
    document.querySelector('#side-toggle-btn > .fa').classList.add('fa-angle-right')
  }
}

window.jqueryFuncs = () => {
  $('.datetimepicker').datetimepicker({
    sideBySide: true,
    format: 'YYYY-MM-DD HH:mm'
  })
  $('.datepicker').datetimepicker({
    format: 'YYYY-MM-DD'
  })
  $('.timepicker').datetimepicker({
    format: 'HH:mm'
  })
  $('[data-toggle="tooltip"]').tooltip()
  $('body, [data-dismiss="modal"]').click(() => {
    return $('.modal').modal('hide')
  })
  $('.modal-content').click(event => event.stopPropagation())

  if (document.getElementById('side-toggle-btn').binded) return
  document.getElementById('side-toggle-btn').binded = true

  document.getElementById('side-toggle-btn').addEventListener('click', (event) => {
    toggleAsideExpanded()
  })
}

jQuery.extend(true, jQuery.fn.datetimepicker.defaults, {
  icons: {
    time: 'fa fa-clock',
    date: 'fa fa-calendar',
    up: 'fa fa-arrow-up',
    down: 'fa fa-arrow-down',
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-calendar-check',
    clear: 'fa fa-trash-alt',
    close: 'fa fa-times-circle'
  }
})
