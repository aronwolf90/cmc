import ProjectsShow from '../../../../app/javascript/store/modules/projects-show.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Store.Modules.ProjectsShow', () => {
  const projectComment = {
    id: 1,
    type: 'project-comments',
    attributes: {
      content: 'Content'
    }
  }

  describe('.getters', () => {
    describe('.comments', () => {
      it('transform boardListsRefs to a boardList list', () => {
        const result = ProjectsShow.getters.comments({
          projectCommentRefs: [{ id: 1, type: 'comments' }]
        },
        {},
        {},
        {
          projectComment () { return projectComment }
        })

        expect(result).to.eql([projectComment])
      })
    })
  })
  describe('.actions', () => {
    describe('.fetch', () => {
      ProjectsShow.actions.fetch({
        dispatch (method, id) {
          if (id !== 1 && method !== 'getProjectComments') return
          return Promise.resolve({ data: [projectComment] })
        },
        commit () {}
      })
    })
    describe('.createComment', () => {
      ProjectsShow.actions.createComment({
        dispatch (method, payload) {
          expect(method).to.eq('createProjectComment')
          return Promise.resolve({ data: { data: projectComment } })
        },
        getters: {
          comments: [projectComment]
        },
        commit () {}
      },
      {})
    })
  })
  describe('.mutations', () => {
    let state = {}
    ProjectsShow.mutations.comments(state, [projectComment])
    expect(state).to.eql({ projectCommentRefs: [ { id: 1, type: 'project-comments' } ] })
  })
})
