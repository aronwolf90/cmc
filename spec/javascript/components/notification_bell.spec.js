import { mount, createLocalVue } from '@vue/test-utils'
import NotificationBell from '../../../app/javascript/components/notification_bell'
import BootstrapVue from 'bootstrap-vue'
import Vuex from 'vuex'

const localVue = createLocalVue()
localVue.use(Vuex)
localVue.use(BootstrapVue)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('NotificationBell', () => {
  it('show spinner when the promise is not resolved', (done) => {
    const store = new Vuex.Store({
      actions: {
        getNotifications () {
          return new Promise(() => {})
        }
      }
    })
    const wrapper = mount(NotificationBell, { store, localVue })
    wrapper.find('button').click

    wrapper.vm.$nextTick(() => {
      expect(wrapper.find('.fa-spinner').exists()).to.be.true
      done()
    })
  })

  it('show message when no notifications exist', (done) => {
    const store = new Vuex.Store({
      actions: {
        getNotifications () {
          return Promise.resolve({
            data: [],
            links: { next: null },
            meta: { 'unread-count': 0 }
          })
        }
      }
    })
    const wrapper = mount(NotificationBell, { store, localVue })
    wrapper.find('button').click

    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.html()).to.be.include('There are no notifications yet')
        done()
      })
    })
  })
})
