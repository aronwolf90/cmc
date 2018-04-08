import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import SharedIssueSection from '../../app/javascript/shared_issue_section'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('SharedIssueSection', () => {
  subject(() => shallow(SharedIssueSection, { store: $store, localVue }))

  def('getters', () => ({
    associatedEntry () { return () => $currentIssue },
    currentRecord () { return $currentRecord },
    collection () { return () => [$currentIssue] }
  }))
  def('actions', () => ({ initBoardsLists () {} }))
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
      attributes: { 'start-time': $startTime }
    }))
    def('currentIssue', () => ({
      id: 1,
      type: 'issues',
      attributes: { title: 'current issue title' },
      relationships: { 'board-list': { data: { id: 1 } } }
    }))
    def('currentBoardList', () => ({ id: 1, type: 'board-lists' }))
    def('startTime', () => 'Wed Feb 21 2018 12:30:10 GMT+0000 (UTC)')

    it("has currentsIssue's title", () => {
      expect($subject.html()).to.include('current issue title')
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
})
