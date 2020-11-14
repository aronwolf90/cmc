export default {
  namespaced: true,
  state: {
    form: {
      attributes: {
        'start-time': null,
        'end-time': null
      },
      relationships: {
        issue: {
          data: null
        }
      }
    },
    errors: []
  },
  getters: {
    formIssueRef (state) {
      return state.form.relationships.issue.data
    },
    formStartTime (state) {
      return state.form.attributes['start-time']
    },
    formEndTime (state) {
      return state.form.attributes['end-time']
    },
    errors (state) {
      return state.errors
    }
  },
  mutations: {
    clear (state, comments) {
      state.form = {
        attributes: {
          'start-time': null,
          'end-time': null
        },
        relationships: {
          issue: {
            data: null
          }
        }
      }
    },
    formStartTime (state, startTime) {
      state.form.attributes['start-time'] = startTime
    },
    formEndTime (state, startTime) {
      state.form.attributes['end-time'] = startTime
    },
    formIssueRef (state, issueRef) {
      state.form.relationships.issue.data = issueRef
    },
    errors (state, errors) {
      state.errors = errors
    }
  },
  actions: {
    initializeNewForm (context) {
      context.commit('clear')
      context.dispatch('get', 'issues', { root: true })
    },
    create (context) {
      return context.dispatch('create', {
        resource: 'records',
        payload: context.state.form
      }, { root: true })
        .then(() => true)
        .catch(({ data }) => {
          context.commit('errors', data.errors)
          return false
        })
    }
  }
}
