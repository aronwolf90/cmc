import JsonApi from 'store/json_api'

import JsonApiGetters from 'store/json_api/getters'

import recordActions from 'store/models/record_actions'
import issueActions from 'store/models/issue_actions'
import commentActions from 'store/models/comment_actions'
import boardListActions from 'store/models/board_list_actions'
import projectActions from 'store/models/project_actions'
import userActions from 'store/models/user_actions'
import wikiCategoryActions from 'store/models/wiki_category_actions'
import wikiPageActions from 'store/models/wiki_page_actions'
import folderActions from 'store/models/folder_actions'
import userIssueActions from 'store/models/user_issue_actions'

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
    currentRecord (store, getters) {
      return JsonApiGetters.associatedEntry(store.json_api)({
        entry: getters.currentUser,
        name: 'current-record'
      })
    },
    currentIssue (state, getters) {
      return getters.associatedEntry({
        entry: getters.currentRecord,
        name: 'issue'
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
    },
    relevantProjects (state, getters) {
      return (searchText) => {
        if (!getters.collection('projects')) return
        let relevantProjects = getters.collection('projects').slice()
        return relevantProjects.filter(relevantProject => {
          return relevantProject.attributes.name.includes(searchText)
        })
      }
    }
  },
  actions: {
    ...boardListActions,
    ...commentActions,
    ...issueActions,
    ...projectActions,
    ...recordActions,
    ...userActions,
    ...wikiCategoryActions,
    ...wikiPageActions,
    ...folderActions,
    ...userIssueActions,

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
