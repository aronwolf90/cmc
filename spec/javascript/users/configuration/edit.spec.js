import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Edit from '../../../../app/javascript/users/configuration/edit'
import BootstrapVue from 'bootstrap-vue'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(BootstrapVue)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Edit', () => {
  subject(() => mount(Edit, { store: $store, localVue }))

  def('getters', () => ({
    getUser () { return () => $user }
  }))
  def('actions', () => ({
    getUser () { return Promise.resolve({ data: $user }) }
  }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('user', () => ({ id: 1, type: 'users', attributes: { type: 'Admin' } }))

  it('type input has value Admin', (done) => {
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        expect($subject.vm.data.attributes.type).to.eq('Admin')
        expect($subject.find('select').element.value).to.eq('Admin')
        done()
      })
    })
  })

  it('call destroyUser when click on delete btn', (done) => {
    $actions['destroyUser'] = (_context, user) => {
      expect(user).to.eq($user)
      done()
      return new Promise(() => {})
    }
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        $subject.find('button.btn-destroy').trigger('click')
        expect($subject.vm.data.attributes.type).to.eq('Admin')
        expect($subject.find('select').element.value).to.eq('Admin')
      })
    })
  })
})
