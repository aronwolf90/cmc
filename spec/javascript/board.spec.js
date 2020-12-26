import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Board from 'pages/board-lists/index'
import List from 'board/list'
import ProjectSelect from 'board/project_select'
import SearchSelect from 'board/search_select'
import draggable from 'vuedraggable'
import sinon from 'sinon'
import BootstrapVue from 'bootstrap-vue'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Board', () => {
  subject(() => shallow(
    Board, {
      store: $store, localVue, router, stubs: { draggable }
    }
  ))

  def('getters', () => ({
    boardLists () {
      return $boardLists
    }
  }))
  def('actions', () => ({
    getBoardLists () {},
    sortBoardLists () {}
  }))
  def('store', () => (new Vuex.Store({
    modules: {
      board: {
        namespaced: true,
        getters: $getters,
        actions: $actions
      }
    }
  })))
  def('Turbolinks', () => ({ visit: sinon.spy() }))
  def('boardLists', () => [])

  beforeEach(() => (global.Turbolinks = $Turbolinks))

  it('the SearchSelect is present', () => {
    expect($subject.find(SearchSelect).exists()).to.be.true
  })

  describe('with boardLists', () => {
    def('boardList1', () => ({ id: '1', type: 'board-lists' }))
    def('boardList2', () => ({ id: '2', type: 'board-lists' }))
    def('boardLists', () => [$boardList1, $boardList2])

    it('contain the list element', (done) => {
      $subject
      $subject.vm.$nextTick(() => {
        $subject.vm.$nextTick(() => {
          expect($subject.findAll(List).at(0).props().listId).to.be.eq('1')
          expect($subject.findAll(List).at(1).props().listId).to.be.eq('2')
          done()
        })
      })
    })

    it('contain the board-select element', () => {
      expect($subject.find(ProjectSelect).exists()).to.be.true
    })

    it('change board_list order', (done) => {
      let boardLists = [$boardList2, $boardList1]
      $actions.sortBoardLists = function sortBoardLists (context, localBoardLists) {
        expect(localBoardLists).to.eq(boardLists)
        done()
      }
      $subject.vm.boardLists = boardLists
    })
  })

  describe('without boardLists', () => {
    it('contain the list element', () => {
      expect($subject.findAll(List).length).to.eq(0)
    })
  })
})
