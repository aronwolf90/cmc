const endpoint = '/api/v1'

export default {
  initProjects (context) {
    return context.dispatch('get', {
      endpoint,
      resource: 'projects'
    })
  },
  getProject (context, id) {
    return context.dispatch('get', {
      endpoint,
      resource: `projects/${id}`
    })
  },
  getSelectedProject (context) {
    context.dispatch('initCurrentUser').then(() => {
      let currentUser = context.getters.currentUser
      let project = currentUser.relationships['selected-project'].data
      if (context.getters.project(project.id)) {
        return Promise.resolve({ data: context.getters.project(project.id) })
      }
      return context.dispatch('getProject', project.id)
    })
  }
}
