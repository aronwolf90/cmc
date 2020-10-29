import { mount, createLocalVue } from '@vue/test-utils'
import ProjectsLeftAside from '../../../app/javascript/components/projects-left-aside'
import BootstrapVue from 'bootstrap-vue'
import Vuex from 'vuex'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('ProjectsLeftAside', () => {
  const projectStatus1 = {
    id: 1,
    type: 'project-statuses',
    attributes: {
      name: 'New',
      initial: true
    }
  }

  it('show spinner when the promise is not resolved', (done) => {
    const dispatch = sandbox.stub()
    const wrapper = mount(ProjectsLeftAside, {
      router,
      localVue,
      mocks: {
        $store: {
          getters: {
            'projectsLeftAside/projectStatuses': [projectStatus1]
          },
          dispatch
        }
      }
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(wrapper.html()).to.include('New')
          done()
        })
      })
    })
  })
})
