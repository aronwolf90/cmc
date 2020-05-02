import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import SharedIssueSection from '../../app/javascript/shared_issue_section'
import CurrentIssue from '../../app/javascript/shared_issue_section/current_issue'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('SharedIssueSection', () => {
  subject(() => shallow(SharedIssueSection, { store: $store, localVue }))

  def('getters', () => ({
    associatedEntry () { return () => $currentIssue },
    currentRecord () { return $currentRecord }
  }))
  def('actions', () => ({ initBoardsLists () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))

  beforeEach(() => {
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

    it('contain currentIssue', () => {
      expect($subject.find(CurrentIssue).exists()).to.be.true
    })
  })
})
