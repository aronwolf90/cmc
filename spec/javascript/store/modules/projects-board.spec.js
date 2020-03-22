import Board from '../../../../app/javascript/store/modules/projects-board.js'
import sinon from 'sinon'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Modules.ProjectsBoard', () => {
  const project1 = { id: '1', type: 'projects' }
  const project2 = { id: '2', type: 'projects' }
  const projectRef1 = { id: '1', type: 'projects' }
  const projectRef2 = { id: '2', type: 'projects' }
  const projectBoardList1 = {
    id: '1',
    type: 'project-board-lists',
    relationships: { projects: { data: [projectRef1, projectRef2] } }
  }
  const projectBoardList2 = {
    id: '2',
    type: 'project-board-lists',
    relationships: { projects: { data: [projectRef1, projectRef2] } }
  }
  const projectBoardListRef1 = { id: '1', type: 'project-board-lists' }
  const projectBoardListRef2 = { id: '2', type: 'project-board-lists' }
  const projectStatus = {
    id: '2',
    type: 'project-statuses',
    relationships: {
      'project-board-lists': { data: [projectBoardListRef1, projectBoardListRef2] }
    }
  }

  describe('.getters', () => {
    describe('.projectBoardLists', () => {
      it('transform projectBoardListsRefs to a projectBoardList list', () => {
        const result = Board.getters.projectBoardLists(
          {
            projectBoardListRefs: [
              { id: '1', type: 'project-board-lists' },
              { id: '2', type: 'project-board-lists' }
            ]
          },
          {}, {},
          {
            entry ({ id, type }) {
              if (id === '1') return projectBoardList1
              if (id === '2') return projectBoardList2
            }
          }
        )

        expect(result).to.eql([projectBoardList1, projectBoardList2])
      })
    })
    describe('.projectBoardListProjects', () => {
      it('transform projectBoardListIssueRefs to a projects list', () => {
        const result = Board.getters.projectBoardListProjects(
          {
            projectBoardListProjectRefs: {
              1: [projectRef1, projectRef2]
            }
          },
          {}, {},
          {
            entry ({ id, type }) {
              if (type !== 'projects') return null
              if (id === '1') return project1
              if (id === '2') return project2
            }
          }
        )(projectBoardList1)

        expect(result).to.eql([project1, project2])
      })
    })
  })

  describe('.mutations', () => {
    describe('.projectBoardLists', () => {
      it('set projectBoardListRefs', () => {
        const state = {}

        Board.mutations.projectBoardLists(
          state,
          [projectBoardList1, projectBoardList2]
        )

        expect(state.projectBoardListRefs).to.eql([
          projectBoardListRef1,
          projectBoardListRef2
        ])
      })
    })
    describe('.projectBoardListProjects', () => {
      it('set projectBoardListProjectRefs', () => {
        const state = {}

        Board.mutations.projectBoardListProjects(state, {
          projectBoardList: projectBoardList1,
          projects: [project1, project2]
        })

        expect(state.projectBoardListProjectRefs).to.eql({
          1: [projectRef1, projectRef2]
        })
      })
    })
  })

  describe('.actions', () => {
    describe('.fetch', () => {
      it('calls commit("boardLists", args)', (done) => {
        Board.actions.fetch({
          commit: (method, projectBoardLists) => {
            if (method !== 'projectBoardLists') return null
            expect(projectBoardLists)
              .to.eql([projectBoardListRef1, projectBoardListRef2])
            done()
          },
          dispatch: sinon
            .stub()
            .withArgs('getProjectBoardLists', null, { root: true })
            .returns(Promise.resolve({
              data: projectStatus
            })),
          getters: {
            projectBoardLists: [projectBoardList1]
          }
        })
      })
      it('calls commit("projectBoardListIssues", args)', (done) => {
        Board.actions.fetch({
          commit: (method, params) => {
            if (method !== 'projectBoardListProjects') return null
            expect(params).to.eql({
              projectBoardList: projectBoardList1,
              projects: [projectRef1, projectRef2]
            })
            done()
          },
          dispatch: sinon
            .stub()
            .withArgs('getProjectStatus', null, { root: true })
            .returns(Promise.resolve({
              data: projectStatus
            })),
          getters: {
            projectBoardLists: [projectBoardList1]
          }
        })
      })
    })
  })
})
