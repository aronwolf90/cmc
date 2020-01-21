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
  subject(() => mount(Edit, {
    store: $store,
    localVue,
    attachToDocument: true
  }))

  def('getters', () => ({
    getUser () { return () => $user }
  }))
  def('actions', () => ({
    getUser () { return Promise.resolve({ data: $user }) }
  }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('user', () => ({
    id: 1,
    type: 'users',
    attributes: {
      type: 'Admin',
      active: true
    }
  }))

  it('type input has value Admin', (done) => {
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        expect($subject.vm.data.attributes.type).to.eq('Admin')
        expect($subject.find('select').element.value).to.eq('Admin')
        done()
      })
    })
  })

  it('active input has value true', (done) => {
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        expect($subject.vm.data.attributes.active).to.eq(true)
        expect($subject.find('input').element.value).to.eq('true')
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

  it('call updateUserConfiguration when click on submit btn', (done) => {
    $actions['updateUserConfiguration'] = (_context, { user, payload }) => {
      expect(user).to.eq($user)
      expect(payload).to.eql({
        attributes: {
          type: 'Admin',
          active: true
        }
      })
      done()
      return new Promise(() => {})
    }
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        $subject.find('[type="submit"]').trigger('click')
        $subject.vm.$nextTick()
      })
    })
  })
})
