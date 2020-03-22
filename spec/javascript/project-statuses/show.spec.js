import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Index from '../../../app/javascript/project-statuses/show'
import BootstrapVue from 'bootstrap-vue'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('ShowIssue', () => {
  let project = {
    id: 1,
    type: 'projects',
    attributes: {
      name: 'Issue 1'
    }
  }
  let projectStatus = {
    id: 1,
    type: 'project-statuses',
    attributes: {
      name: 'New'
    },
    relationships: {
      projects: {
        data: [project]
      }
    }
  }
  let store = {
    getters: {
      project () {
        return () => project
      },
      projectStatus () {
        return () => projectStatus
      }
    },
    actions: {
      getProjectStatus () {
        return Promise.resolve({ data: projectStatus })
      }
    }
  }

  it('show title', (done) => {
    const wrapper = mount(Index, { store: new Vuex.Store(store), localVue, router })

    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(wrapper.html()).to.include('New')
          done()
        })
      })
    })
  })

  it('show projects', (done) => {
    const wrapper = mount(Index, { store: new Vuex.Store(store), localVue, router })

    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.html()).to.include('Issue 1')
        done()
      })
    })
  })

  it('call destroyProjectStatus', (done) => {
    store.actions['destroyProjectStatus'] = (projectStatus) => {
      expect(projectStatus).not.to.be.eq(null)
      done()
    }
    const wrapper = mount(Index, { store: new Vuex.Store(store), localVue, router })

    wrapper.find('.fa-trash').trigger('click')
  })
})
