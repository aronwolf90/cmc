import { Utils } from 'vuex-jsonapi-client'

export default {
  namespaced: true,
  state: {
    projectCommentRefs: [],
    projectId: null,
    telephoneNumber: {
      value: '+49 821 598-1111',
      editMode: false
    },
    email: {
      value: 'aron.wolf@sumcumo.com',
      editMode: false
    }
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
    },
    contact (state, getters, _rootState, rootGetters) {
      return rootGetters.associatedEntry({
        entry: getters.project,
        name: 'contact'
      })
    },
    telephoneNumberValue (state) {
      return state.telephoneNumber.value
    },
    telephoneNumberEditMode (state) {
      return state.telephoneNumber.editMode
    },
    emailValue (state) {
      return state.email.value
    },
    emailEditMode (state) {
      return state.email.editMode
    }
  },
  mutations: {
    comments (state, comments) {
      state.projectCommentRefs = Utils.entryArrayToRef(comments)
    },
    projectId (state, projectId) {
      state.projectId = projectId
    },
    telephoneNumberValue (state, value) {
      state.telephoneNumber.value = value
    },
    telephoneNumberEditMode (state, value) {
      state.telephoneNumber.editMode = value
    },
    emailValue (state, value) {
      state.email.value = value
    },
    emailEditMode (state, value) {
      state.email.editMode = value
    }
  },
  actions: {
    fetch (context, id) {
      context.commit('projectId', id)
      context.dispatch('getProject', id, { root: true }).then(response => {
        context.commit(
          'telephoneNumberValue',
          Utils.attribute(context.getters.contact, 'telephone')
        )
        context.commit(
          'emailValue',
          Utils.attribute(context.getters.contact, 'email')
        )
      })
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
