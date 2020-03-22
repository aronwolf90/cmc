import { Utils } from 'vuex-jsonapi-client'
import Vue from 'vue/dist/vue.common'

export default {
  namespaced: true,
  state: {
    projectBoardListRefs: null,
    projectBoardListProjectRefs: {}
  },
  getters: {
    projectBoardLists (state, _getters, _rootState, rootGetters) {
      if (!state.projectBoardListRefs) return []
      return state.projectBoardListRefs.map(ref => rootGetters.entry(ref))
    },
    projectBoardListProjects (state, _getters, _rootState, rootGetters) {
      return (projectBoardList) => {
        return state.projectBoardListProjectRefs[projectBoardList.id]
          .map(ref => rootGetters.entry(ref))
      }
    }
  },
  mutations: {
    projectBoardLists (state, projectBoardLists) {
      Vue.set(state, 'projectBoardListRefs',
        Utils.entryArrayToRef(projectBoardLists))
    },
    projectBoardListProjects (state, { projectBoardList, projects }, other) {
      if (!state.projectBoardListProjectRefs) {
        state.projectBoardListProjectRefs = {}
      }
      Vue.set(state.projectBoardListProjectRefs,
        projectBoardList.id, Utils.entryArrayToRef(projects))
    }
  },
  actions: {
    fetch (context, projectStatusId) {
      context.dispatch('getProjectStatus', projectStatusId,
        { root: true }
      ).then(response => {
        context.commit(
          'projectBoardLists',
          Utils.relationship(response.data, 'project-board-lists')
        )
        context.getters.projectBoardLists.forEach(projectBoardList => {
          context.commit('projectBoardListProjects', {
            projectBoardList,
            projects: Utils.relationship(projectBoardList, 'projects')
          })
        })
      })
    }
  }
}
