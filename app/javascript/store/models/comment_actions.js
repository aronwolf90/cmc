const endpoint = '/api/v1'

export default {
  createComment (context, payload) {
    return context.dispatch('create', {
      resource: `comments`,
      endpoint,
      payload
    })
  }
}
