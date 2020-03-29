import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ProjectStatusNew from '../../../app/javascript/project-statuses/new'
import BootstrapVue from 'bootstrap-vue'
import sinon from 'sinon'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

const sandbox = sinon.createSandbox()

describe('ProjectStatusNew', () => {
  afterEach(() => sandbox.restore())

  it('calls createProjectStatus when submit is clicked', (done) => {
    let wrapper = mount(ProjectStatusNew, {
      router,
      store: new Vuex.Store({
        actions: {
          createProjectStatus (_, { attributes }) {
            expect(attributes).to.eql({
              name: 'New',
              'display-as': 'list'
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
      })
    })
  })

  it('show errors when they are present', (done) => {
    let wrapper = mount(ProjectStatusNew, {
      store: new Vuex.Store({
        actions: {
          createProjectStatus ({ attributes }) {
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