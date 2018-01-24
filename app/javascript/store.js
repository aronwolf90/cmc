import Vue from 'vue/dist/vue.common'
import JsonApi from 'store/json_api'

export default {
  strict: true,
  modules: {
    json_api: JsonApi
  },
  state: {
  },
  actions: {
    initIssue(context, issue_id) {
      context.dispatch('initEntry', {
        url: `/api/v1/issues/${issue_id}`, type: 'issues'
      })
    },
    refreshIssue(context) {
      context.dispatch('refresh', '/api/v1/issues')
    },
    initBoardsLists(context) {
      context.dispatch('initCollection', {
        url: '/api/v1/board_lists', type: 'board_lists'
      })
    },
    refreshBoardLists(context) {
      this.dispatch('refresh', '/api/v1/board_lists')
    },
    initUsers(context) {
      context.dispatch('initCollection', {
        url: '/api/v1/users/', type: 'users'
      })
    },
    refreshUsers(context) {
      this.dispatch('refresh', '/api/v1/users')
    },
    updateBoardListIssues(context, { id, issues }) {
      context.commit('updateBoardListIssues', { id: id, issues: issues})
      let board_list = context.state.board_lists.find(board_list => board_list.id == id)

      Vue.http.put(`/api/v1/board_lists/${board_list.id}`, { board_list }).then(response => {
      }, response => {
        alert(response)
      })
    },
    updateBoardLists(context, board_lists) {
      context.commit('refreshBoardLists', { data: board_lists })

      let data = []

      for (let index = 0; index < board_lists.length; index++) {
        let entry = board_lists[index]
        entry.attributes.ordinal_number = index

        data.push({
          "op": "update",
          "value": entry
        })
      }

      Vue.http.patch('/api/v1/board_lists', { data: data }).then(response => {
        context.commit('refreshBoardLists', response.data)
      }, response => {
        alert(response)
      })
    },
    createComment(context, { issue_id, payload, func_success }) {
      context.dispatch('create', {
        url: `/api/v1/issues/${issue_id}/comments`,
        payload: { data: payload },
        func_success: func_success
      })
    },
    changeIssueToUserReference(context, { issue, user, func_success }) {
      context.dispatch('changeOneToManyReference', {
        child: issue,
        parent: user,
        child_relationship_name: 'user',
        parent_relationship_name: 'issues',
      })
    },
    changeOneToManyReference(context, { child, parent, parent_relationship_name, child_relationship_name, func_success }) {
      let data = { data: { relationships: { }}}
      data.data.relationships[child_relationship_name] = { data: { id: parent.id, type: parent.type }}

      Vue.http.put(child.links.self, data)
        .then(response => {
          context.commit('removeFromAll', {
            child: child,
            parent: parent,
            child_relationship_name: child_relationship_name,
            parent_relationship_name: parent_relationship_name
          })
          context.commit('addToMultiple', {
            parent: parent,
            child: child,
            relationship_name: parent_relationship_name })
          context.commit('setAssotiation', {
            parent: parent,
            child: child,
            relationship_name: child_relationship_name
          })
          if (func_success) func_success()
        }, response => {
          alert(response)
        })
    }
  }
}
