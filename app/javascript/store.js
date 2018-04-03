import JsonApi from 'store/json_api'
import * as Utils from './store/json_api/utils'

import JsonApiGetters from 'store/json_api/getters'

const endpoint = '/api/v1'

export default {
  strict: true,
  modules: {
    json_api: JsonApi
  },
  getters: {
    currentUser (store) {
      let entry = JsonApiGetters.get(store.json_api)({
        type: 'contexts',
        id: 'context'
      })

      return JsonApiGetters.getAssociatedEntry(store.json_api)({
        entry,
        name: 'current-user'
      })
    },
    currentRecord (store) {
      let context = JsonApiGetters.get(store.json_api)({
        type: 'contexts',
        id: 'context'
      })

      let currentUser = JsonApiGetters.getAssociatedEntry(store.json_api)({
        entry: context,
        name: 'current-user'
      })

      return JsonApiGetters.getAssociatedEntry(store.json_api)({
        entry: currentUser,
        name: 'current-record'
      })
    }
  },
  actions: {
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
    },
    initIssue (context, issueId) {
      return context.dispatch('initEntry', { endpoint, resource: `issues/${issueId}` })
    },
    initContext (context) {
      return context.dispatch('initEntry', { endpoint, resource: 'context' })
    },
    initBoardsLists (context) {
      return context.dispatch('initEntry', { endpoint, resource: 'board_lists' })
    },
    initUsers (context) {
      return context.dispatch('initEntry', { endpoint, resource: 'users' })
    },
    updateBoardList (context, { entry, attributes }) {
      let payload = {
        id: entry.id,
        type: entry.type,
        attributes
      }
      context.commit('update', { entry, payload })
      return context.dispatch('update', { entry, payload })
    },
    updateContext (context, boardLists) {

    },
    createComment (context, { issue, user, attributes }) {
      let payload = {
        attributes,
        'relationships': {
          'issue': { 'data': Utils.entryToRef(issue) },
          'user': { 'data': Utils.entryToRef(user) }
        }
      }

      context.dispatch('create', {
        url: `/api/v1/comments`,
        payload
      }).then(comment => {
        context.commit('addToMultiple', {
          parent: issue,
          child: comment,
          relationshipName: 'comments'
        })
        context.commit('addToMultiple', {
          parent: user,
          child: comment,
          relationshipName: 'comments'
        })
        return comment
      })
    },
    createRecord (context, { attributes, user, issue }) {
      context.dispatch('create', {
        url: `/api/v1/records`,
        payload: {
          attributes,
          relationships: {
            user: { data: user },
            issue: { data: issue }
          }
        }
      }).then(record => {
        context.commit('setAssociation', {
          parent: record,
          child: user,
          relationshipName: 'current-record'
        })
      })
    },
    updateRecord (context, { entry, payload }) {
      context.dispatch('update', { entry, payload })
      if (payload.attributes['end-time'] &&
        context.getters.currentRecord.id === entry.id) {
        context.commit('setAssociation', {
          parent: null,
          child: context.getters.currentUser,
          relationshipName: 'current-record'
        })
      }
    },
    changeIssueToUserReference (context, { issue, user }) {
      context.dispatch('changeOneToManyReference', {
        child: issue,
        parent: user,
        childRelationshipName: 'user',
        parentRelationshipName: 'issues'
      })
    },
    updateBoardListIssues (context, { boardList, issues }) {
      context.dispatch('changeManyToOneReference', {
        children: issues,
        parent: boardList,
        childRelationshipName: 'board-list',
        parentRelationshipName: 'issues',
        endpoint
      })
    }
  }
}
