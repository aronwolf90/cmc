import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import DueAt from 'components/ticket/deadline-at'
import BootstrapVue from 'bootstrap-vue'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(BootstrapVue)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('DeadlineAt', () => {
  it('call updateIssue when submit button is clicked', (done) => {
    const issue = { attributes: { 'deadline-at': '10-10-2020 00:00' } }
    const store = new Vuex.Store({
      getters: {
        issue () { return () => issue }
      },
      actions: {
        initIssue () {
          return Promise.resolve({ data: issue })
        },
        updateIssue (context, { attributes }) {
          expect(attributes['deadline-at']).to.eq('10-10-2020 00:00')
          done()
        }
      }
    })
    let wrapper = mount(DueAt, { store, localVue, attachToDocument: true })
    wrapper.vm.$nextTick(() => {
      wrapper.find('[type="submit"]').trigger('click')
    })
  })

  it('show spinner when waiting for updateIssue Promise', (done) => {
    const issue = { attributes: { 'deadline-at': '10-10-2020 00:00' } }
    let promiseResolve = null
    const promise = new Promise((resolve) => {
      promiseResolve = resolve
    })
    const store = new Vuex.Store({
      getters: {
        issue () { return () => issue }
      },
      actions: {
        initIssue () {
          return Promise.resolve({ data: issue })
        },
        updateIssue (context, { attributes }) {
          return promise
        }
      }
    })
    let wrapper = mount(DueAt, { store, localVue, attachToDocument: true })
    wrapper.vm.$nextTick(() => {
      wrapper.find('[type="submit"]').trigger('click')
      wrapper.vm.$nextTick(() => {
        expect(wrapper.find('.fa-spinner').exists()).to.be.true
        promiseResolve()
        wrapper.vm.$nextTick(() => {
          wrapper.vm.$nextTick(() => {
            expect(wrapper.find('.fa-spinner').exists()).to.be.false
            done()
          })
        })
      })
    })
  })
})
