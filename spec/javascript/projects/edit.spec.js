import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ProjectEdit from '../../../app/javascript/projects/edit'
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

describe('ProjectEdit', () => {
  const project = {
    id: 1,
    type: 'projects',
    attributes: {
      name: 'Test'
    }
  }
  const projectStatus = {
    id: 1,
    type: 'project-statuses',
    attributes: {
      name: 'Archived'
    }
  }

  it('calls updateProject when submit is clicked', (done) => {
    let wrapper = mount(ProjectEdit, {
      router,
      store: new Vuex.Store({
        getters: {
          projectStatuses () {
            return [projectStatus]
          },
          project () {
            return () => project
          }
        },
        actions: {
          getProject () {
            return Promise.resolve({ data: project })
          },
          updateProject (_, { payload }) {
            expect(payload.attributes).to.eql({ name: 'Test' })
            expect(payload.relationships).to.eql({
              'project-status': { data: null }
            })
            done()
            return Promise.resolve()
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          wrapper.find('#input-name').element.value = 'Test'
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

  it('project status options are present', (done) => {
    let wrapper = mount(ProjectEdit, {
      router,
      store: new Vuex.Store({
        getters: {
          projectStatuses () {
            return [projectStatus]
          },
          project () {
            return () => project
          }
        },
        actions: {
          getProject () {
            return Promise.resolve({ data: project })
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(wrapper.html()).to.include('Archived')
          done()
        })
      })
    })
  })

  it('render destroy btn', (done) => {
    let wrapper = mount(ProjectEdit, {
      router,
      store: new Vuex.Store({
        getters: {
          projectStatuses () {
            return [projectStatus]
          },
          project () {
            return () => project
          }
        },
        actions: {
          getProject () {
            return Promise.resolve({ data: project })
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(wrapper.html()).to.include('Destroy')
          done()
        })
      })
    })
  })

  it('show errors when they are present', (done) => {
    let wrapper = mount(ProjectEdit, {
      store: new Vuex.Store({
        getters: {
          projectStatuses () {
            return [projectStatus]
          },
          project () {
            return () => project
          }
        },
        actions: {
          getProject () {
            return Promise.resolve({ data: project })
          },
          updateProject ({ attributes }) {
            return Promise.reject({
              status: 'fail',
              data: {
                errors: [{ source: { pointer: 'attributes/name' } }]
              }
            })
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.find('[type="submit"]').trigger('click')
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
