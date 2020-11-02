import { Utils } from 'vuex-jsonapi-client'

export default {
  namespaced: true,
  state: {
    commentRefs: [],
    boardListRefs: [],
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
    },
    boardLists (state, _getters, rootState, rootGetters) {
      return state.boardListRefs.map(ref => {
        return rootGetters.entry(ref)
      })
    }
  },
  mutations: {
    comments (state, comments) {
      state.commentRefs = Utils.entryArrayToRef(comments)
    },
    issueId (state, issueId) {
      state.issueId = issueId
    },
    boardLists (state, boardLists) {
      state.boardListRefs = Utils.entryArrayToRef(boardLists)
    }
  },
  actions: {
    fetch (context, id) {
      context.commit('issueId', id)
      const getIssuePromisse = context.dispatch('get', `issues/${id}?include=board_list`, { root: true })
      const getIssuesCommentsPromise = context.dispatch('getIssueComments', id, { root: true }).then(response => {
        context.commit('comments', response.data)
      })
      const getLabelsPromise = context.dispatch('getLabels', null, { root: true })
      const getBoardListsPromise = context.dispatch('getBoardLists', null, { root: true }).then(response => {
        context.commit('boardLists', response.data)
      })
      return Promise.all([getIssuePromisse, getIssuesCommentsPromise, getLabelsPromise, getBoardListsPromise])
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
    },
    updateBoardList (context, boardList) {
      return context.dispatch(
        'updateIssue',
        {
          entry: context.getters.issue,
          boardList: Utils.entryToRef(boardList)
        },
        { root: true }
      )
    }
  }
}
