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
  const project = {
    id: 1,
    type: 'projects',
    attributes: {
      name: 'project'
    },
    relationships: {
      contact: {
        data: null
      }
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
          if (id !== 1 && method !== 'getProjectComments') {
            return Promise.resolve({ data: [projectComment] })
          }
          if (id !== 1 && method !== 'getProject') {
            return Promise.resolve({ data: project })
          }
          if (id !== 1 && method !== 'getContacts') {
            return Promise.resolve({ data: [] })
          }
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
    describe('.closeIssue', () => {
      it('calls dispatch.closeIssue', () => {
        ProjectsShow.actions.closeIssue({
          dispatch (method, payload) {
            expect(method).to.eq('closeIssue')
          },
          commit () {}
        },
        {})
      })
      it('calls commit.removeReminder', () => {
        ProjectsShow.actions.closeIssue({
          dispatch (method, payload) {},
          commit (method) {
            expect(method).to.eq('removeReminder')
          }
        },
        {})
      })
    })
  })
  describe('.mutations', () => {
    it('comments', () => {
      let state = {}
      ProjectsShow.mutations.comments(state, [projectComment])
      expect(state).to.eql({ projectCommentRefs: [ { id: 1, type: 'project-comments' } ] })
    })
    it('removeReminder', () => {
      let state = {
        reminderRefs: [
          { id: '1', type: 'issues' },
          { id: '2', type: 'issues' }
        ]
      }
      ProjectsShow.mutations.removeReminder(state, {
        id: '1',
        type: 'issues'
      })
      expect(state).to.eql({
        reminderRefs: [ { id: '2', type: 'issues' } ]
      })
    })
  })
})
