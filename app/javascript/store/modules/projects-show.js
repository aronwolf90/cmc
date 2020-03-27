import { Utils } from 'vuex-jsonapi-client'

export default {
  namespaced: true,
  state: {
    projectCommentRefs: [],
    projectId: null
  },
  getters: {
    comments (state, _getters, rootState, rootGetters) {
      return state.projectCommentRefs.map(ref => {
        return rootGetters.projectComment(ref.id)
      })
    },
    project (state, _getters, rootState, rootGetters) {
      return rootGetters.project(state.projectId)
    },
    currentUser (state, _getters, rootState, rootGetters) {
      return rootGetters.currentUser
    }
  },
  mutations: {
    comments (state, comments) {
      state.projectCommentRefs = Utils.entryArrayToRef(comments)
    },
    projectId (state, projectId) {
      state.projectId = projectId
    }
  },
  actions: {
    fetch (context, id) {
      context.commit('projectId', id)
      context.dispatch('getProject', id, { root: true })
      context.dispatch('getProjectComments', id, { root: true }).then(result => {
        context.commit('comments', result.data)
      })
    },
    createComment (context, payload) {
      payload['relationships'] = {
        project: {
          data: context.getters.project
        },
        user: {
          data: context.getters.currentUser
        }
      }

      return context.dispatch(
        'createProjectComment',
        payload,
        { root: true }
      ).then(response => {
        context.commit('comments', context.getters.comments.concat(response.data.data))
      })
    }
  }
}
