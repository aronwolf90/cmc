import JsonApi from 'store/json_api'

import JsonApiGetters from 'store/json_api/getters'

import recordActions from 'store/models/record_actions'
import issueActions from 'store/models/issue_actions'
import commentActions from 'store/models/comment_actions'
import boardListActions from 'store/models/board_list_actions'
import userActions from 'store/models/user_actions'

export default {
  strict: true,
  modules: {
    json_api: JsonApi
  },
  getters: {
    currentUser (store) {
      let entry = JsonApiGetters.entry(store.json_api)({
        type: 'contexts',
        id: 'context'
      })

      return JsonApiGetters.associatedEntry(store.json_api)({
        entry,
        name: 'current-user'
      })
    },
    currentRecord (store) {
      let context = JsonApiGetters.entry(store.json_api)({
        type: 'contexts',
        id: 'context'
      })

      let currentUser = JsonApiGetters.associatedEntry(store.json_api)({
        entry: context,
        name: 'current-user'
      })

      return JsonApiGetters.associatedEntry(store.json_api)({
        entry: currentUser,
        name: 'current-record'
      })
    },
    relevantIssues (state, getters) {
      return (searchText) => {
        if (!getters.collection('issues')) return
        let relevantIssues = getters.collection('issues').slice()
        return relevantIssues.filter(relevantIssue => {
          return relevantIssue.attributes.title.includes(searchText)
        })
      }
    }
  },
  actions: {
    ...boardListActions,
    ...commentActions,
    ...issueActions,
    ...recordActions,
    ...userActions,

    initCurrentUser (context) {
      return context.dispatch('initContext').then(contextEntry => {
        return context.dispatch('initRelatedEntry', {
          entry: contextEntry,
          name: 'current-user'
        })
      })
    },
    initCurrentRecord (context) {
      return context.dispatch('initCurrentUser').then(currentUser => {
        return context.dispatch('initRelatedEntry', {
          entry: currentUser,
          name: 'current-record'
        })
      })
    }
  }
}
