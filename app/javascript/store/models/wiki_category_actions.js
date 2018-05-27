const endpoint = '/api/v1'

export default {
  initWikiCategories (context) {
    return context.dispatch('initEntry', { endpoint, resource: 'wiki_categories' })
  }
}
