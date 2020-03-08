const endpoint = '/api/v1'

export default {
  getProjectStatuses (context) {
    return context.dispatch('get', { endpoint, resource: 'project_statuses' })
  },
  getProjectStatus (context, id) {
    return context.dispatch('get', {
      endpoint,
      resource: `project_statuses/${id}?include=projects`
    })
  }
}
