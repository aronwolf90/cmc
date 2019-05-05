import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import BodyCell from '../../../app/javascript/attendances/body_cell'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('BodyCell', () => {
  subject(() => shallow(BodyCell, { store: $store, localVue }))

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

  it('render day kind class', () => {
    expect($subject.html()).to.include('class="holiday-day"')
  })

  it('render table cell', () => {
    expect($subject.html()).to.include('<td')
  })
})
