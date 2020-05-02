import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Issue from '../../../app/javascript/board/issue'
import IssuesRecordSection from '../../../app/javascript/components/issues_record_section'
import draggable from 'vuedraggable'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Issue', () => {
  subject(() => shallow(Issue, {
    store: $store, localVue, propsData: { issueId: 1, boardListId: 1 }, stubs: { draggable } }))

  def('getters', () => ({
    entry () { return () => $issue }
  }))
  def('actions', () => ({ initBoardsLists () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))

  describe('when the issue is present and his data is correct', () => {
    def('issue', () => ({
      id: 1,
      type: 'issues',
      name: 'name',
      attributes: { title: 'issues title' }
    }))

    it('include show link', () => {
      expect($subject.html()).to.include('issues/1')
    })

    it('pass issueId to issue-record-section', () => {
      expect($subject.find(IssuesRecordSection).props().issueId).to.eq(1)
    })
  })
})
