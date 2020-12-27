import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Attendances from 'pages/attendances/index'
import UserCell from 'attendances/user_cell'
import HeaderCell from 'attendances/header_cell'
import BodyCell from 'attendances/body_cell'
import AsyncComputed from 'vue-async-computed'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(AsyncComputed)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Attendances', () => {
  subject(() => shallow(Attendances, { store: $store, localVue }))

  def('actions', () => ({
    attendanceDays () { return Promise.resolve({ data: [$attendanceDay], links: { meta: { prev: '01-01-2019', next: '29-01-2019' } } }) },
    attendanceEvents () { return Promise.resolve([]) },
    users () { return Promise.resolve([$user]) }
  }))
  def('getters', () => ({
    users () { return [$user] }
  }))
  def('store', () => (new Vuex.Store({
    state: {},
    actions: $actions,
    getters: $getters
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
        $subject.vm.$nextTick(() => {
          expect($subject.find(HeaderCell).exists()).to.be.true
          done()
        })
      })
    })
  })
  it('render BodyCell', done => {
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        $subject.vm.$nextTick(() => {
          expect($subject.find(BodyCell).exists()).to.be.true
          done()
        })
      })
    })
  })
})
