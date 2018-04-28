import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Board from '../../app/javascript/board'
import List from '../../app/javascript/board/list'
import draggable from 'vuedraggable'
import sinon from 'sinon'
import { FormInput } from 'bootstrap-vue/es/components'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(FormInput)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Board', () => {
  subject(() => shallow(Board, { store: $store, localVue, stubs: { draggable } }))

  def('getters', () => ({ metaCollection () { return () => $boardLists } }))
  def('actions', () => ({ initBoardsLists () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('Turbolinks', () => ({ visit: sinon.spy() }))

  beforeEach(() => (global.Turbolinks = $Turbolinks))

  describe('with boardLists', () => {
    def('boardList1', () => ({ id: 1, name: 'name', 'ordinal-number': '1' }))
    def('boardList2', () => ({ id: 2, name: 'name', 'ordinal-number': '1' }))
    def('boardLists', () => [$boardList1, $boardList2])

    it('contain the list element', () => {
      expect($subject.findAll(List).at(0).props().listId).to.be.eq(1)
      expect($subject.findAll(List).at(1).props().listId).to.be.eq(2)
    })

    it('change board_list order', (done) => {
      let boardLists = [$boardList2, $boardList1]
      $actions.sortBoardLists = function sortBoardLists (context, localBoardLists) {
        expect(localBoardLists).to.eq(boardLists)
        done()
      }
      $subject.vm.boardLists = boardLists
    })

    it('call visit on add btn', () => {
      $subject.find('.fa-plus').trigger('click')
      expect($Turbolinks.visit).to.have.been.called
    })

    it('contain the add link', () => {
      expect($subject.html()).to.include('href="/administration/board_lists/new"')
    })
  })

  describe('without boardLists', () => {
    def('boardLists', () => [])

    it('contain the list element', () => {
      expect($subject.findAll(List).length).to.eq(0)
    })

    it('call visit on add btn', () => {
      $subject.find('.fa-plus').trigger('click')
      expect($Turbolinks.visit).to.have.been.called
    })
  })
})
