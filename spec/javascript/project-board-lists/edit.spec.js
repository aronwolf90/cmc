import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ProjectBoardListEdit from '../../../app/javascript/project-board-lists/edit'
import BootstrapVue from 'bootstrap-vue'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('ProjectStatusEdit', () => {
  const projectBoardList = {
    id: 1,
    type: 'project-board-lists',
    attributes: {
      name: 'New'
    },
    relationships: {
      'project-status': {
        data: { id: 1, type: 'project-statuses' }
      }
    },
    meta: {
      permissions: {
        destroy: true
      }
    }
  }
  const store = {
    getters: {
      projectBoardList () {
        return () => projectBoardList
      }
    },
    actions: {
      getProjectBoardList () {
        return Promise.resolve({ data: projectBoardList })
      },
      updateProjectBoardList (_, { attributes }) {
        return Promise.resolve()
      }
    }
  }

  it('calls updateProjectBoardList when submit is clicked', (done) => {
    store.actions['updateProjectBoardList'] = (_, { payload }) => {
      expect(payload.attributes).to.eql({ name: 'New' })
      done()
      return Promise.resolve()
    }
    const wrapper = mount(ProjectBoardListEdit, {
      router,
      store: new Vuex.Store(store),
      localVue,
      attachToDocument: true
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          wrapper.find('#input-name').element.value = 'New'
          wrapper.find('#input-name').trigger('input')
          wrapper.vm.$nextTick(() => {
            wrapper.vm.$nextTick(() => {
              wrapper.find('[type="submit"]').trigger('click')
            })
          })
        })
      })
    })
  })

  it('initialize inputs', (done) => {
    const wrapper = mount(ProjectBoardListEdit, {
      router,
      store: new Vuex.Store(store),
      localVue
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.find('#input-name').element.value).to.eq('New')
        done()
      })
    })
  })

  it('show errors when they are present', (done) => {
    store.actions['updateProjectBoardList'] = (_, { attributes }) => {
      return Promise.reject({
        status: 'fail',
        data: {
          errors: [{ source: { pointer: 'attributes/name' } }]
        }
      })
    }
    const wrapper = mount(ProjectBoardListEdit, {
      store: new Vuex.Store(store),
      localVue,
      attachToDocument: true
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.find('[type="submit"]').trigger('click')
        wrapper.vm.$nextTick(() => {
          wrapper.vm.$nextTick(() => {
            wrapper.vm.$nextTick(() => {
              expect(wrapper.vm.errors).to.eql([{ source: { pointer: 'attributes/name' } }])
              done()
            })
          })
        })
      })
    })
  })
})
