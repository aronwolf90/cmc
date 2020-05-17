import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import List from '../../../../../app/javascript/components/project-statuses/board/list'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(VueRouter)

/* eslint-disable no-undef, no-unused-expressions */

describe('project-statuses/board/list', () => {
  const projectBoardList = {
    id: '1',
    type: 'project-board-lists',
    attributes: {
      name: 'Project board list name'
    },
    relationships: {
      projects: {
        links: {
          next: '/next'
        }
      }
    }
  }
  const project = {
    id: '1',
    type: 'projects',
    attributes: {
      name: 'Name'
    }
  }
  const store = new Vuex.Store({
    modules: {
      'projects-board': {
        namespaced: true,
        getters: {
          projectBoardListProjects () {
            return () => [project]
          },
          loadMoreLink () {
            return () => '/next'
          }
        }
      }
    },
    getters: {
      project () {
        return () => project
      },
      projectBoardList () {
        return () => projectBoardList
      }
    }
  })

  it('render project board list name', (done) => {
    const wrapper = mount(List, {
      store,
      localVue,
      router,
      propsData: {
        projectBoardListId: '1'
      },
      stubs: {
        Project: 'stubed-project'
      }
    })
    wrapper.vm.$nextTick(() => {
      expect(wrapper.html()).to.include('Project board list name')
      done()
    })
  })

  it('render project board list name', (done) => {
    const wrapper = mount(List, {
      store,
      localVue,
      router,
      propsData: {
        projectBoardListId: '1'
      },
      stubs: {
        Project: '<div>stubed-project</div>'
      }
    })
    wrapper.vm.$nextTick(() => {
      expect(wrapper.html()).to.include('stubed-project')
      done()
    })
  })

  it('renders more', (done) => {
    const wrapper = mount(List, {
      store,
      localVue,
      router,
      propsData: {
        projectBoardListId: '1'
      },
      stubs: {
        Project: '<div>stubed-project</div>'
      }
    })
    wrapper.vm.$nextTick(() => {
      expect(wrapper.html()).to.include('more')
      done()
    })
  })
})
