import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import New from '../../../app/javascript/records/new'
import BootstrapVue from 'bootstrap-vue'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(BootstrapVue)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

const sandbox = sinon.createSandbox()

describe('Edit', () => {
  let createInstance = store => mount(New, {
    store: new Vuex.Store(store),
    localVue,
    attachToDocument: true
  })
  let user = {
    id: 1,
    type: 'records'
  }

  afterEach(() => sandbox.restore())

  it('calls createUser when submit is clicked', (done) => {
    let wrapper = createInstance({
      actions: {
        createRecord () {
          done()
          return Promise.resolve({ data: user })
        }
      }
    })
    sandbox.stub(window.location, 'replace')
    wrapper.find('[type="submit"]').trigger('click')
  })

  it('calls location.replate when no error is present', (done) => {
    let wrapper = createInstance({
      actions: {
        createRecord () {
          return Promise.resolve({ data: user })
        }
      }
    })
    sandbox.stub(window.location, 'replace').callsFake(() => { done() })
    wrapper.find('[type="submit"]').trigger('click')
  })

  it('show errors when they are present', (done) => {
    let wrapper = createInstance({
      actions: {
        createRecord () {
          return Promise.reject({
            status: 'fail',
            data: {
              errors: ['test']
            }
          })
        }
      }
    })
    wrapper.find('[type="submit"]').trigger('click')
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        console.log(wrapper.vm._data.errors)
        expect(wrapper.vm.errors).to.eql(['test'])
        done()
      })
    })
  })
})
