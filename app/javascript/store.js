import JsonApi from 'vuex-jsonapi-client'

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
import eventActions from 'store/models/event_actions'

export default {
  strict: true,
  modules: {
    json_api: JsonApi
  },
  getters: {
    currentUser (store) {
      let entry = JsonApi.getters.entry(store.json_api)({
        type: 'contexts',
        id: 'context'
      })

      return JsonApi.getters.associatedEntry(store.json_api)({
        entry,
        name: 'current-user'
      })
    },
    currentRecord (store, getters) {
      return JsonApi.getters.associatedEntry(store.json_api)({
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
    ...eventActions,

    initCurrentUser (context) {
      return context.dispatch('initContext').then(currentContext => {
        return context.dispatch('initRelatedEntry', {
          entry: currentContext,
          name: 'current-user'
        })
      })
    },
    initCurrentRecord (context) {
      return context.dispatch('initCurrentUser').then(currentUser => {
        return context.dispatch('initRelatedEntry', {
          entry: currentUser,
          name: 'current-record?include=issue'
        })
      })
    }
  }
}
