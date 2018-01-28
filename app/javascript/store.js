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
    initBoardsLists(context) {
      context.dispatch('initCollection', {
        url: '/api/v1/board_lists', type: 'board_lists'
      })
    },
    initUsers(context) {
      context.dispatch('initCollection', {
        url: '/api/v1/users/', type: 'users'
      })
    },
    updateBoardListIssues(context, { id, issues }) {
      context.commit('updateBoardListIssues', { id: id, issues: issues})
      let board_list = context.state.board_lists.find(board_list => board_list.id == id)

      Vue.http.put(`/api/v1/board_lists/${board_list.id}`, { board_list }).then(response => {
      }, response => {
        alert(response)
      })
    },
    createComment(context, { issue, payload, func_success }) {
      context.dispatch('create', {
        url: `/api/v1/issues/${issue.id}/comments`,
        payload,
        func_success: (comment) => {
          context.commit('addToMultiple', {
            parent: issue,
            child: comment,
            relationship_name: 'comments'
          })
          if (func_success) func_success()
        }
      })
    },
    changeIssueToUserReference(context, { issue, user, func_success }) {
      context.dispatch('changeOneToManyReference', {
        child: issue,
        parent: user,
        child_relationship_name: 'user',
        parent_relationship_name: 'issues',
      })
    }
  }
}
