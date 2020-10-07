import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import IssuesRecordSection from '../../../app/javascript/components/issues_record_section'
import CurrentRecord from '../../../app/javascript/shared_issue_section/current_record'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('CurrentRecord', () => {
  subject(() => shallow(CurrentRecord, { store: $store, localVue }))

  def('getters', () => ({
    currentRecord () { return $currentRecord }
  }))
  def('actions', () => ({ initCurrentRecord () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('Turbolinks', () => ({ visit: sinon.spy() }))

  beforeEach(() => {
    global.Turbolinks = $Turbolinks
    this.clock = sinon.useFakeTimers(new Date('Wed Feb 21 2018 12:30:10 GMT+0000 (UTC)'))
  })
  afterEach(() => (this.clock = this.clock.restore()))

  describe('with currentRecord', () => {
    def('currentRecord', () => ({
      id: 1,
      type: 'records',
      attributes: { 'start-time': $startTime },
      relationships: { issue: { data: { id: 1, type: 'records' } } }
    }))
    def('startTime', () => 'Wed Feb 21 2018 12:30:10 GMT+0000 (UTC)')

    it('pass issueId to issue-record-section', () => {
      expect($subject.find(IssuesRecordSection).props().issueId).to.eq(1)
    })

    describe('when start-time is some seconds in the past', () => {
      def('startTime', () => 'Wed Feb 21 2018 12:30:8 GMT+0000 (UTC)')

      it('return the correct spended time', () => {
        expect($subject.vm.consumedTime()).to.eq('00:00:02')
      })
    })
    describe('when start-time is some minutes in the past', () => {
      def('startTime', () => 'Wed Feb 21 2018 12:28:10 GMT+0000 (UTC)')

      it('return the correct spended time', () => {
        expect($subject.vm.consumedTime()).to.eq('00:02:00')
      })
    })
    describe('when start-time is some hours in the past', () => {
      def('startTime', () => 'Wed Feb 21 2018 10:30:10 GMT+0000 (UTC)')

      it('return the correct spended time', () => {
        expect($subject.vm.consumedTime()).to.eq('02:00:00')
      })
    })
  })
  describe('without currentRecord', () => {
    def('currentRecord', () => undefined)

    it('render nothing', () => {
      expect($subject.html()).to.be.empty
    })
  })
})
