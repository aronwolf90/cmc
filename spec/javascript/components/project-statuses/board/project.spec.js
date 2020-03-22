import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Project from '../../../../../app/javascript/components/project-statuses/board/project'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(VueRouter)

/* eslint-disable no-undef, no-unused-expressions */

describe('project-statuses/board/project', () => {
  const project = {
    id: '1',
    type: 'projects',
    attributes: {
      name: 'Name'
    }
  }

  it('render project name', (done) => {
    const store = new Vuex.Store({
      getters: {
        project () {
          return () => project
        }
      }
    })
    const wrapper = mount(Project, {
      store,
      localVue,
      router,
      propsData: {
        projectId: '1'
      }
    })
    wrapper.vm.$nextTick(() => {
      expect(wrapper.html()).to.include('Name')
      done()
    })
  })
})
