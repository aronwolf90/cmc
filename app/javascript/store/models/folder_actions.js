const endpoint = '/api/v1'

export default {
  initFolders (context) {
    return context.dispatch('get', {
      endpoint,
      resource: 'folders?include[]=documents'
    })
  }
}
