import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Board from '../../../../app/javascript/components/project-statuses/board'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(VueRouter)

/* eslint-disable no-undef, no-unused-expressions */

describe('project-statuses/board', () => {
  const projectBoardList = {
    id: '1',
    type: 'project-board-lists',
    attributes: {
      name: 'Name'
    }
  }

  it('render project name', (done) => {
    const store = new Vuex.Store({
      modules: {
        'projects-board': {
          namespaced: true,
          getters: {
            projectBoardLists () {
              return [projectBoardList]
            }
          }
        }
      },
      getters: {
        projectBoardList () {
          return () => projectBoardList
        }
      }
    })
    const wrapper = mount(Board, {
      store,
      localVue,
      router,
      propsData: {
        projectStatusId: '1'
      },
      stubs: {
        'list': '<div>Project board list</div>'
      }
    })
    wrapper.vm.$nextTick(() => {
      expect(wrapper.html()).to.include('Project board list')
      done()
    })
  })
})
