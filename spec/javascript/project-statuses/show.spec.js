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

describe('project-statuses/show.vue', () => {
  let project = {
    id: 1,
    type: 'projects',
    attributes: {
      name: 'Project 1'
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
      entry () {
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

  it('show projects', async () => {
    const wrapper = mount(Index, { store: new Vuex.Store(store), localVue, router })

    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    console.log(wrapper.vm.projects)
    console.log(wrapper.vm.projectBoard)
    expect(wrapper.html()).to.include('Project 1')
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
