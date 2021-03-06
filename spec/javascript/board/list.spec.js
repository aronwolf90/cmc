import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import List from '../../../app/javascript/board/list'
import Issue from '../../../app/javascript/board/issue'
import draggable from 'vuedraggable'
import BootstrapVue from 'bootstrap-vue'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(BootstrapVue)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('List', () => {
  subject(() => shallow(List, {
    store: $store, localVue, propsData: { listId: 1 }, stubs: { draggable }
  }))

  def('getters', () => ({
    entry () { return () => $boardList },
    associatedEntries () { return () => $issues }
  }))
  def('actions', () => ({ initBoardsLists () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))

  describe('when the boardList is present and his data is correct', () => {
    def('boardList', () => ({
      id: 1,
      type: 'boardLists',
      name: 'name',
      attributes: {
        name: 'board list name',
        complexity: '1.0'
      },
      relationships: { issues: { data: $issues } }
    }))
    def('issue1', () => ({ id: 1, type: 'issues', attributes: { name: 'name1' } }))
    def('issue2', () => ({ id: 2, type: 'issues', attributes: { name: 'name2' } }))
    def('issues', () => [$issue1, $issue2])

    it('contain the title', () => {
      expect($subject.html()).to.include('board list name')
    })

    it('contain the complexity', () => {
      expect($subject.html()).to.include('1.0')
    })

    it('contain the Issue element with correct issueId', () => {
      expect($subject.findAll(Issue).at(0).props().issueId).to.be.eq(1)
      expect($subject.findAll(Issue).at(1).props().issueId).to.be.eq(2)
    })

    it('contain the Issue element with correct boardListId', () => {
      expect($subject.findAll(Issue).at(0).props().boardListId).to.be.eq(1)
      expect($subject.findAll(Issue).at(1).props().boardListId).to.be.eq(1)
    })
  })

  describe('when the boardList is not present', () => {
    def('boardList', () => undefined)

    it('render nothing', () => {
      expect($subject.html()).to.empty
    })
  })
})
