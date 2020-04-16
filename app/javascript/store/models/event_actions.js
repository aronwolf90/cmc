const endpoint = '/api/v1'

export default {
  initEvents (context) {
    return context.dispatch('get', { endpoint, resource: 'events' })
  },
  getEvents (context) {
    return context.dispatch('get', { endpoint, resource: 'events' })
  },
  createEvent (context, { attributes }) {
    let payload = { attributes }

    return context.dispatch('create', {
      payload,
      endpoint,
      resource: '/events'
    })
  },
  updateEvent (context, { entry, attributes }) {
    let payload = {
      id: entry.id,
      type: entry.type,
      attributes
    }
    return context.dispatch('update', { entry, payload, endpoint })
  },
  destroyEvent (context, entry) {
    return context.dispatch('destroy', { entry })
  }
}
