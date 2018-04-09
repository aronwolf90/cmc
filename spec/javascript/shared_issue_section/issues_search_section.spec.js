import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import IssuesSearchSection from '../../../app/javascript/shared_issue_section/issues_search_section'
import Issue from '../../../app/javascript/shared_issue_section/issue'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('IssuesSearchSection', () => {
  subject(() => shallow(IssuesSearchSection, { store: $store, localVue }))

  def('getters', () => ({
    currentIssue () { return $currentIssue },
    relevantIssues () { return () => [$issue1, $issue2] }
  }))
  def('actions', () => ({ initCurrentIssue () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('Turbolinks', () => ({ visit: sinon.spy() }))

  def('issue1', () => ({ id: 1, type: 'issues' }))
  def('issue2', () => ({ id: 2, type: 'issues' }))

  beforeEach(() => { global.Turbolinks = $Turbolinks })

  describe('with currentIssue', () => {
    def('currentIssue', () => $issue1)

    it('render one issue', () => {
      expect($subject.findAll(Issue).length).to.eq(1)
    })
  })
  describe('without currentRecord', () => {
    def('currentIssue', () => undefined)

    it('render two issue', () => {
      expect($subject.findAll(Issue).length).to.eq(2)
    })
  })
})
