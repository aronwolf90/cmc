export const helperState = {
  enabledGetters: {
  }
}

export const helperMutations = {
  enable (state, getter) {
    state.enabledGetters[getter] = true
  }
}

export const helperGetters = {
  currentIssue (state) {
    if (!state.enabledGetters.currentIssue) return undefined
    return state.getterData.currentIssue
  },
  relevantIssues (state) {
    console.log(state.enabledGetters.relevantIssues)
    if (!state.enabledGetters.relevantIssues) return () => undefined
    return state.getterData.relevantIssues
  }
}

export const helperActions = {
  initIssues (context) {
    context.commit('enable', 'relevantIssues')
  },
  initCurrentIssue (context) {
    context.commit('enable', 'currentIssue')
  }
}
