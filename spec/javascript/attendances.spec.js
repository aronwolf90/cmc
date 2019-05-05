import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Attendances from '../../app/javascript/attendances'
import UserCell from '../../app/javascript/attendances/user_cell'
import HeaderCell from '../../app/javascript/attendances/header_cell'
import BodyCell from '../../app/javascript/attendances/body_cell'
import AsyncComputed from 'vue-async-computed'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(AsyncComputed)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Attendances', () => {
  subject(() => shallow(Attendances, { store: $store, localVue }))

  def('actions', () => ({
    users () { return Promise.resolve([$user]) },
    attendanceDays () { return Promise.resolve([$attendanceDay]) }
  }))
  def('store', () => (new Vuex.Store({
    state: {},
    actions: $actions
  })))

  def('user', () => ({
    id: '1',
    type: 'users',
    attributes: {
      firstname: 'user'
    }
  }))
  def('attendanceDay', () => ({
    id: '2019-01-01',
    type: 'attendance-days',
    attributes: {
      day: '2019-01-01'
    }
  }))

  it('render UserCell', done => {
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        expect($subject.find(UserCell).exists()).to.be.true
        done()
      })
    })
  })
  it('render HeaderCell', done => {
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        expect($subject.find(HeaderCell).exists()).to.be.true
        done()
      })
    })
  })
  it('render BodyCell', done => {
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        expect($subject.find(BodyCell).exists()).to.be.true
        done()
      })
    })
  })
})
