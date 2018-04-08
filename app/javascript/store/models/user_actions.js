const endpoint = '/api/v1'

export default {
  initContext (context) {
    return context.dispatch('initEntry', { endpoint, resource: 'context' })
  }
}
