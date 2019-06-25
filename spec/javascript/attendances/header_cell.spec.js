import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import HeaderCell from '../../../app/javascript/attendances/header_cell'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('HeaderCell', () => {
  subject(() => shallow(HeaderCell, { store: $store, localVue }))

  def('getters', () => ({
    entry () { return () => { return $attendanceDay } }
  }))
  def('store', () => (new Vuex.Store({
    state: {},
    getters: $getters
  })))

  def('attendanceDay', () => ({
    id: '2019-01-01',
    type: 'attendance-days',
    attributes: {
      day: '2019-01-01',
      kind: 'holiday-day'
    }
  }))

  it('render the element', () => {
    expect($subject.html()).to.include('class="text-nowrap holiday-day">Tue 1</td>')
  })
})
