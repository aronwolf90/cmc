import Vue from 'vue'
import VueResource from 'vue-resource'

import Actions from '../../../../app/javascript/store/models/board_list_actions'

import sinon from 'sinon'
import sinonStubPromise from 'sinon-stub-promise'

/* eslint-disable no-undef */

Vue.use(VueResource)
sinonStubPromise(sinon)

describe('Actions', () => {
  describe('#sortBoardLists', () => {
    def('boardList1', () => ({ id: 1, type: 'board-lists' }))
    def('boardList2', () => ({ id: 2, type: 'board-lists' }))
    def('context', () => ({ dispatch: sinon.spy(), commit: sinon.spy() }))

    it('call Actions#request', () => {
      Actions.sortBoardLists($context, [$boardList1, $boardList2])

      expect($context.dispatch).to.have.been.calledWith('request', {
        url: '/api/v1/board_lists/sort',
        method: 'put',
        payload: [1, 2]
      })
    })

    it('call changeMetaCollection', () => {
      Actions.sortBoardLists($context, [$boardList1, $boardList2])

      expect($context.commit).to.have.been.calledWith('changeMetaCollection', {
        name: 'board_lists',
        collection: [$boardList1, $boardList2]
      })
    })
  })
})
