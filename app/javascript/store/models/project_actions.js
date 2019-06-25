const endpoint = '/api/v1'

export default {
  initProjects (context) {
    return context.dispatch('get', {
      endpoint,
      resource: 'projects'
    })
  }
}
