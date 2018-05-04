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
  entry (state) {
    if (!state.enabledGetters.entry) return () => undefined
    return () => state.getterData.entry
  },
  currentIssue (state) {
    if (!state.enabledGetters.currentIssue) return undefined
    return state.getterData.currentIssue
  },
  relevantIssues (state) {
    if (!state.enabledGetters.relevantIssues) return () => undefined
    return state.getterData.relevantIssues
  }
}

export const helperActions = {
  initIssues (context) {
    context.commit('enable', 'relevantIssues')
  },
  initIssue (context) {
    context.commit('enable', 'entry')
  },
  initCurrentIssue (context) {
    context.commit('enable', 'currentIssue')
  }
}
