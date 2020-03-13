import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Index from '../../../app/javascript/project-statuses/show'
import BootstrapVue from 'bootstrap-vue'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(BootstrapVue)

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

  it('show projects', (done) => {
    const wrapper = mount(Index, {
      store: new Vuex.Store({
        getters: {
          project () {
            return () => project
          }
        },
        actions: {
          getProjectStatus () {
            return Promise.resolve({ data: projectStatus })
          }
        }
      }),
      localVue
    })

    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.html()).to.include('Issue 1')
        done()
      })
    })
  })
})
