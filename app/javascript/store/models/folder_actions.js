const endpoint = '/api/v1'

export default {
  initFolders (context) {
    return context.dispatch('initEntry', { endpoint, resource: 'folders' })
  }
}
