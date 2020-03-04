const endpoint = '/api/v1'

export default {
  getContext (context) {
    return context.dispatch('get', { endpoint, resource: 'context' })
  }
}
