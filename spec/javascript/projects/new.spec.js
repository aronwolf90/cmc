import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ProjectNew from '../../../app/javascript/projects/new'
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

describe('ProjectNew', () => {
  const projectStatus = {
    id: 1,
    type: 'project-statuses',
    attributes: {
      name: 'Test'
    }
  }

  it('calls createProject when submit is clicked', (done) => {
    let wrapper = mount(ProjectNew, {
      router,
      store: new Vuex.Store({
        getters: {
          projectStatuses () {
            return [projectStatus]
          }
        },
        actions: {
          getContacts () {
            return Promise.resolve({ data: [] })
          },
          createProject (_, { attributes, relationships }) {
            expect(attributes).to.eql({
              name: 'New',
              description: null
            })
            expect(relationships).to.eql({
              'project-status': { data: null },
              'contact': { data: null }
            })
            done()
            return Promise.resolve()
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.find('#input-name').element.value = 'New'
    wrapper.find('#input-name').trigger('input')
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.find('[type="submit"]').trigger('click')
        done()
      })
    })
  })

  it('show errors when they are present', (done) => {
    let wrapper = mount(ProjectNew, {
      store: new Vuex.Store({
        getters: {
          projectStatuses () {
            return [projectStatus]
          }
        },
        actions: {
          getContacts () {
            return Promise.resolve({ data: [] })
          },
          createProject ({ attributes }) {
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
      attachToDocument: true,
      stubs: [ 'markdown-editor' ]
    })
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
