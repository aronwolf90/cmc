import Vue from 'vue/dist/vue.esm'

export default {
  strict: true,
  state: {
    columns: []
  },
  mutations: {
    updateBoardLists(state, payload) {
      state.columns = payload
    }
  },
  actions: {
    refreshBoardLists(context) {
      Vue.http.get('/administration/board_lists').then(response => {
        context.commit('updateBoardLists', response.data.data)
      }, response => {
        alert(response)
      })
    },
    initBoardsLists(context) {
      if (this.state.columns.length) return
      this.dispatch('refreshBoardLists')
    }
  }
}
