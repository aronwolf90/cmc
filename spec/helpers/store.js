var sinon = require('sinon')
var sinonStubPromise = require('sinon-stub-promise')
sinonStubPromise(sinon)

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
  metaCollection (state) {
    console.log(state.enabledGetters)
    if (!state.enabledGetters.metaCollection) return () => undefined
    return state.getterData.metaCollection
  }
}

export const helperActions = {
  initIssues (context) {
    context.commit('enable', 'metaCollection')
  },
  initIssue (context) {
    context.commit('enable', 'entry')
  },
  initCurrentIssue (context) {
    context.commit('enable', 'currentIssue')
  },
  request () { return () => sinon.stub().returnsPromise() },
  add () { return () => sinon.stub().returnsPromise() }
}
