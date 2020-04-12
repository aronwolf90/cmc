import { Utils } from 'vuex-jsonapi-client'

export default {
  namespaced: true,
  state: {
    projectCommentRefs: [],
    projectId: null,
    contact: {
      name: {
        value: '',
        editMode: false
      },
      telephoneNumber: {
        value: '',
        editMode: false
      },
      email: {
        value: '',
        editMode: false
      }
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
    contactNameValue (state) {
      return state.contact.name.value
    },
    contactNameEditMode (state) {
      return state.contact.name.editMode
    },
    contactTelephoneNumberValue (state) {
      return state.contact.telephoneNumber.value
    },
    contactTelephoneNumberEditMode (state) {
      return state.contact.telephoneNumber.editMode
    },
    contactEmailValue (state) {
      return state.contact.email.value
    },
    contactEmailEditMode (state) {
      return state.contact.email.editMode
    }
  },
  mutations: {
    comments (state, comments) {
      state.projectCommentRefs = Utils.entryArrayToRef(comments)
    },
    projectId (state, projectId) {
      state.projectId = projectId
    },
    contactNameValue (state, value) {
      state.contact.name.value = value
    },
    contactNameEditMode (state, value) {
      state.contact.name.editMode = value
    },
    contactTelephoneNumberValue (state, value) {
      state.contact.telephoneNumber.value = value
    },
    contactTelephoneNumberEditMode (state, value) {
      state.contact.telephoneNumber.editMode = value
    },
    contactEmailValue (state, value) {
      state.contact.email.value = value
    },
    contactEmailEditMode (state, value) {
      state.contact.email.editMode = value
    }
  },
  actions: {
    fetch (context, id) {
      context.commit('projectId', id)
      context.dispatch('getProject', id, { root: true }).then(response => {
        context.commit(
          'contactNameValue',
          Utils.attribute(context.getters.contact, 'name')
        )
        context.commit(
          'contactTelephoneNumberValue',
          Utils.attribute(context.getters.contact, 'telephone')
        )
        context.commit(
          'contactEmailValue',
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
