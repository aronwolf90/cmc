const endpoint = '/api/v1'

export default {
  initProjects (context) {
    return context.dispatch('initEntry', { endpoint, resource: 'projects' })
  }
}
