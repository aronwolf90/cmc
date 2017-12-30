import Vue from 'vue/dist/vue.esm'

var refresh = (state, payload) => {
  var map = {}

  for (var entry of payload) {
    var type = entry.type.replace('-', '_')

    if (!state[type]) state[type] = []

    if (!map[type]) {
      map[type] = {}
      for (var stored_entry of state[type]) {
        map[type][entry.id] = stored_entry
      }
    }
    map[type][entry.id] = entry
  }

  for (let type_data of Object.entries(map)) {
    let data = []

    for (let entry of Object.entries(type_data[1])) {
      data.push(entry[1])
    }

    state[type] = data
  }
}

export default {
  strict: true,
  state: {
    board_lists: [],
    issues: []
  },
  mutations: {
    refreshBoardLists(state, payload) {
      state.board_lists = payload.data
      if (payload['included']) refresh(state, payload.included)
    },
    updateBoardListIssues(state, { id, issues }) {
      let index = state.board_lists.findIndex(entry => entry.id == id)
      state.board_lists[index].relationships.issues.data = issues
    },
    destroyBoardList(state, id) {
      let index = state.board_lists.findIndex(entry => entry.id == id)
      state.board_lists.splice(index, 1)
    }
  },
  getters: {
    getBoardListIssues(state) {
      return board_list => {
        let ids = board_list.relationships.issues.data.map(issue_reference => issue_reference.id)
        return state.issues.filter(issue => ids.includes(issue.id))
      }
    },
    getIssue(state) {
      return id => {
        return state.issues.find(issue => issue.id == id)
      }
    }
  },
  actions: {
    initBoardsLists(context) {
      if (this.state.board_lists.length) return
      this.dispatch('refreshBoardLists')
    },
    refreshBoardLists(context) {
      Vue.http.get('/api/v1/board_lists').then(response => {

        context.commit('refreshBoardLists', response.data)
      }, response => {
        alert(response)
      })
    },
    updateBoardListIssues(context, { id, issues }) {
      context.commit('updateBoardListIssues', { id: id, issues: issues})
      let board_list = context.state.board_lists.find(board_list => board_list.id == id)

      Vue.http.put(`/api/v1/board_lists/${board_list.id}`, { board_list }).then(response => {
        // context.commit('updateBoardListIssues', { response.data })
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
    destroyBoardList(context, id) {
      context.commit('destroyBoardList', id)

      Vue.http.delete(`/api/v1/board_lists/${id}`)
        .then(response => {}, response => {
          alert(response)
        })
    }
  }
}
