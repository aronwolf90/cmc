import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import UserCell from '../../../app/javascript/attendances/user_cell'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('UserCell', () => {
  subject(() => shallow(UserCell, { store: $store, localVue }))

  def('getters', () => ({
    entry () { return () => { return $user } }
  }))
  def('store', () => (new Vuex.Store({
    state: {},
    getters: $getters
  })))

  def('user', () => ({
    id: '1',
    type: 'users',
    attributes: {
      firstname: 'user'
    }
  }))

  it('render the element', () => {
    expect($subject.html()).to.eq('<td>user</td>')
  })
})
