import { Utils } from 'vuex-jsonapi-client'

export default {
  namespaced: true,
  state: {
    commentRefs: [],
    issueId: null
  },
  getters: {
    comments (state, _getters, rootState, rootGetters) {
      return state.commentRefs.map(ref => {
        return rootGetters.comment(ref.id)
      })
    },
    issue (state, _getters, rootState, rootGetters) {
      return rootGetters.issue(state.issueId)
    },
    currentUser (state, _getters, rootState, rootGetters) {
      return rootGetters.currentUser
    }
  },
  mutations: {
    comments (state, comments) {
      state.commentRefs = Utils.entryArrayToRef(comments)
    },
    issueId (state, issueId) {
      state.issueId = issueId
    }
  },
  actions: {
    fetch (context, id) {
      context.commit('issueId', id)
      context.dispatch('getIssue', id, { root: true }).then(response => {
        context.commit('comments', Utils.relationship(response.data, 'comments'))
      })
      // context.dispatch('getComments', id, { root: true }).then(result => {
      //  context.commit('comments', result.data)
      //  })
    },
    createComment (context, payload) {
      payload['relationships'] = {
        issue: {
          data: context.getters.issue
        },
        user: {
          data: context.getters.currentUser
        }
      }

      return context.dispatch(
        'createComment',
        payload,
        { root: true }
      ).then(response => {
        context.commit('comments', context.getters.comments.concat(response.data.data))
      })
    }
  }
}
