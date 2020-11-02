import IssuesShow from '../../../../app/javascript/store/modules/issues-show.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Store.Modules.IssuesShow', () => {
  const comment = {
    id: 1,
    type: 'comments',
    attributes: {
      content: 'Content'
    }
  }
  const boardList = {
    id: 1,
    type: 'board-lists',
    attributes: {
      name: 'In progress'
    }
  }

  describe('.getters', () => {
    it('.comments', () => {
      const result = IssuesShow.getters.comments({
        commentRefs: [{ id: 1, type: 'comments' }]
      }, {}, {}, {
        comment () { return comment }
      })

      expect(result).to.eql([comment])
    })
    it('.boardLists', () => {
      const entry = sandbox.stub()

      entry.withArgs({ id: 1, type: 'board-lists' }).returns(boardList)
      const result = IssuesShow.getters.boardLists({
        boardListRefs: [{ id: 1, type: 'board-lists' }]
      }, {}, {}, {
        entry
      })

      expect(result).to.eql([boardList])
    })
  })
  describe('.actions', () => {
    it('.fetch', async () => {
      const dispatch = sandbox.stub()
      const commit = sandbox.stub()

      dispatch.returns(Promise.resolve())
      dispatch.withArgs('getIssueComments', '1').returns(Promise.resolve({ data: [comment] }))
      dispatch.withArgs('getBoardLists').returns(Promise.resolve({ data: [boardList] }))
      await IssuesShow.actions.fetch({
        dispatch,
        commit
      }, '1')

      expect(dispatch).to.have.been
        .calledWith('get', `issues/1?include=board_list`, { root: true })
      expect(commit).to.have.been.calledWith('issueId', '1')
      expect(dispatch).to.have.been.calledWith('getIssueComments', '1')
      expect(commit).to.have.been.calledWith('comments', [comment])
      expect(dispatch).to.have.been.calledWith('getLabels')
      expect(dispatch).to.have.been.calledWith('getBoardLists')
      expect(commit).to.have.been.calledWith('boardLists', [boardList])
    })
    describe('.createComment', () => {
      IssuesShow.actions.createComment({
        dispatch (method, payload) {
          expect(method).to.eq('createComment')
          return Promise.resolve({ data: { data: comment } })
        },
        getters: {
          comments: [comment]
        },
        commit () {}
      },
      {})
    })
  })
  describe('.mutations', () => {
    it('.comments', () => {
      let state = {}
      IssuesShow.mutations.comments(state, [comment])
      expect(state).to.eql({
        commentRefs: [ { id: 1, type: 'comments' } ]
      })
    })
    it('.boardLists', () => {
      let state = {}
      IssuesShow.mutations.boardLists(state, [boardList])
      expect(state).to.eql({
        boardListRefs: [ { id: 1, type: 'board-lists' } ]
      })
    })
  })
})
