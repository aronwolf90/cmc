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

  describe('.getters', () => {
    describe('.comments', () => {
      it('transform boardListsRefs to a boardList list', () => {
        const result = IssuesShow.getters.comments({
          commentRefs: [{ id: 1, type: 'comments' }]
        },
        {},
        {},
        {
          comment () { return comment }
        })

        expect(result).to.eql([comment])
      })
    })
  })
  describe('.actions', () => {
    describe('.fetch', () => {
      IssuesShow.actions.fetch({
        dispatch (method, id) {
          if (id !== 1 && method !== 'getIssueComments') return
          return Promise.resolve({ data: [comment] })
        },
        commit () {}
      })
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
    let state = {}
    IssuesShow.mutations.comments(state, [comment])
    expect(state).to.eql({
      commentRefs: [ { id: 1, type: 'comments' } ]
    })
  })
})
