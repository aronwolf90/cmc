import Board from 'store/modules/board.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Modules.Board', () => {
  describe('.getters', () => {
    describe('.boardLists', () => {
      subject(() => Board.getters.boardLists($state, {}, {}, $rootGetters))
      def('state', () => ({
        boardListRefs: [
          { id: '1', type: 'board-lists' },
          { id: '2', type: 'board-lists' }
        ]
      }))
      def('rootGetters', () => ({
        entry ({ id, type }) {
          if (id === '1' && type === 'board-lists') return $boardList1
          if (id === '2' && type === 'board-lists') return $boardList2
        }
      }))
      def('boardList1', () => ({ id: '1', type: 'board-lists' }))
      def('boardList2', () => ({ id: '2', type: 'board-lists' }))
      def('boardLists', () => [$boardList1, $boardList2])

      it('transform boardListsRefs to a boardList list', () => {
        expect($subject).to.eql($boardLists)
      })
    })
  })

  describe('.mutations', () => {
    describe('.boardLists', () => {
      subject(() => Board.mutations.boardLists($state, $boardLists))
      def('state', () => ({}))
      def('boardList1', () => ({ id: '1', type: 'board-lists' }))
      def('boardList2', () => ({ id: '2', type: 'board-lists' }))
      def('boardLists', () => [$boardList1, $boardList2])

      it('set boardListRefs', () => {
        $subject
        expect($state.boardListRefs).to.eql([
          { id: '1', type: 'board-lists' },
          { id: '2', type: 'board-lists' }
        ])
      })
    })
  })

  describe('.actions', () => {
    describe('.getBoardLists', () => {
      it('calls commit("boardLists", args)', (done) => {
        const boardList1 = { id: '1', type: 'board-lists' }
        const boardList2 = { id: '2', type: 'board-lists' }

        Board.actions.getBoardLists({
          commit: (method, boardLists) => {
            expect(method).to.eql('boardLists')
            expect(boardLists).to.eql([boardList1, boardList2])
            done()
          },
          dispatch: sandbox
            .stub()
            .withArgs('getBoardLists', null, { root: true })
            .returns(Promise.resolve({ data: [boardList1, boardList2] }))
        })
      })
    })
    describe('.sortBoardLists', () => {
      it('calls dispatch("sortBoardLists", args)', (done) => {
        const boardList1 = { id: '1', type: 'board-lists' }
        const boardList2 = { id: '2', type: 'board-lists' }

        Board.actions.sortBoardLists(
          {
            commit: (method, boardLists) => {
              expect(method).to.eql('boardLists')
              expect(boardLists).to.eql([boardList1, boardList2])
              done()
            },
            dispatch: () => {}
          },
          [boardList1, boardList2]
        )
      })
      it('calls commit("boardLists", args)', (done) => {
        const boardList1 = { id: '1', type: 'board-lists' }
        const boardList2 = { id: '2', type: 'board-lists' }

        Board.actions.sortBoardLists(
          {
            commit: () => {},
            dispatch: (method, boardLists) => {
              expect(method).to.eql('sortBoardLists')
              expect(boardLists).to.eql([boardList1, boardList2])
              done()
            }
          },
          [boardList1, boardList2]
        )
      })
    })
    describe('.adjustBoardListIssuesRelationshipLinks', () => {
      it('when next link is not present do not set it', (done) => {
        let issues = [{ id: 1, type: 'issues' }]
        let boardList = {
          id: 1,
          type: 'board-lists',
          relationships: {
            issues: {
              data: issues,
              links: {
                next: null,
                self: '/api/v1/board_lists/1'
              }
            }
          }
        }
        Board.actions.adjustBoardListIssuesRelationshipLinks({
          commit: (action, payload) => {
            expect(action).to.eq('relataionshipLinks')
            expect(payload).to.eql({
              entry: boardList,
              association: 'issues',
              links: {
                next: null,
                self: '/api/v1/board_lists/1'
              }
            })
            done()
          }
        }, {
          boardList,
          issues
        })
      })
    })
    describe('.adjustBoardListIssuesRelationshipLinks', () => {
      it('when next link is present, set it', (done) => {
        let issues = [{ id: 1, type: 'issues' }, { id: 2, type: 'issues' }]
        let boardList = {
          id: 1,
          type: 'board-lists',
          relationships: {
            issues: {
              data: issues,
              links: {
                next: '/api/v1/board_lists/1/issues?more_id=1',
                self: '/api/v1/board_lists/1'
              }
            }
          }
        }
        Board.actions.adjustBoardListIssuesRelationshipLinks({
          commit: (action, payload) => {
            expect(action).to.eq('relataionshipLinks')
            expect(payload).to.eql({
              entry: boardList,
              association: 'issues',
              links: {
                next: '/api/v1/board_lists/1/issues?more_id=2',
                self: '/api/v1/board_lists/1'
              }
            })
            done()
          }
        }, {
          boardList,
          issues
        })
      })
    })
    describe('.updateBoardListIssuesOnServer', () => {
      const issue1 = { id: 1, type: 'issues', links: { self: '/api/v1/issues/1' } }
      const issue2 = { id: 2, type: 'issues', links: { self: '/api/v1/issues/2' } }
      const issue3 = { id: 3, type: 'issues', links: { self: '/api/v1/issues/3' } }

      it('do not call updateIssue when a issue is removed', () => {
        const context = {
          rootGetters: {
            associatedEntries: () => [issue1, issue2, issue3]
          },
          dispatch: () => {
            throw new EvalError()
          }
        }

        Board.actions.updateBoardListIssuesOnServer(context, {
          issues: [issue1, issue2]
        })
      })

      it('call updateIssue when a issue is added', () => {
        const context = {
          rootGetters: {
            associatedEntries: () => [issue1, issue2, issue3],
            axios: {
              post: sandbox.stub()
            }
          }
        }
        const issue4 = { id: 4, type: 'issues', links: { self: '/api/v1/issues/4' } }

        Board.actions.updateBoardListIssuesOnServer(context, {
          issues: [issue1, issue2, issue3, issue4],
          boardList: { id: '1', type: 'board-lists' }
        })
        expect(context.rootGetters.axios.post)
          .to.have.been.calledWith('/api/v1/issues/4/move', {
            issue_id: 4,
            before_issue_id: 3,
            board_list_id: '1'
          })
      })

      it('call updateIssue when a issue is sorted', () => {
        const context = {
          rootGetters: {
            associatedEntries: () => [issue1, issue2, issue3],
            axios: {
              post: sandbox.stub()
            }
          }
        }

        Board.actions.updateBoardListIssuesOnServer(context, {
          issues: [issue3, issue2, issue1],
          boardList: { id: '1', type: 'board-lists' }
        })
        expect(context.rootGetters.axios.post)
          .to.have.been.calledWith('/api/v1/issues/1/move', {
            issue_id: 1,
            before_issue_id: 2,
            board_list_id: '1'
          })
      })
    })
  })
})
