import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Edit from '../../../../app/javascript/admin/context/edit'
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
  let context = {
    id: 1,
    type: 'contexts',
    attributes: {
      'time-zone': 'Berlin',
      'global-board': false
    }
  }

  afterEach(() => sandbox.restore())

  it('set attributes from context', (done) => {
    let wrapper = mount(Edit, {
      store: new Vuex.Store({
        actions: {
          getContext () {
            return Promise.resolve({ data: context })
          }
        }
      }),
      localVue
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.vm.form.attributes).to.eql({ 'time-zone': 'Berlin', 'global-board': false })
        done()
      })
    })
  })

  it('calls updateOrganization when submit is clicked', (done) => {
    let wrapper = mount(Edit, {
      store: new Vuex.Store({
        getters: {
          context () { return {} }
        },
        actions: {
          getContext () {
            return context
          },
          updateContext (_, { attributes }) {
            expect(attributes).to.eql({ 'time-zone': 'American Samoa', 'global-board': true })
            done()
            return Promise.resolve()
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.findAll('option').at(1).element.selected = true
    wrapper.find('select').trigger('change')
    wrapper.find('input[type="checkbox"]').trigger('click')
    wrapper.find('input[type="checkbox"]').trigger('change')
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        sandbox.stub(window.location, 'replace')
        wrapper.find('[type="submit"]').trigger('click')
      })
    })
  })

  it('calls location.replate when no error is present', (done) => {
    let wrapper = mount(Edit, {
      store: new Vuex.Store({
        getters: {
          context () { return {} }
        },
        actions: {
          getContext () {
            return Promise.resolve({ data: context })
          },
          updateContext (_, { attributes }) {
            return Promise.resolve()
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.findAll('option').at(1).element.selected = true
    wrapper.find('select').trigger('change')
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        sandbox.stub(window.location, 'replace').callsFake(() => { done() })
        wrapper.find('[type="submit"]').trigger('click')
      })
    })
  })

  it('show errors when they are present', (done) => {
    let wrapper = mount(Edit, {
      store: new Vuex.Store({
        getters: {
          context () { return {} }
        },
        actions: {
          getContext () {
            return Promise.resolve({ data: context })
          },
          updateContext ({ attributes }) {
            return Promise.reject({
              status: 'fail',
              data: {
                errors: [{ source: { pointer: 'attributes/time-zone' } }]
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
          expect(wrapper.vm.errors).to.eql([{ source: { pointer: 'attributes/time-zone' } }])
          done()
        })
      })
    })
  })
})
