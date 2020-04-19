const endpoint = '/api/v1'

export default {
  sortBoardLists (context, boardLists) {
    context.dispatch('request', {
      url: endpoint + '/board_lists/sort',
      method: 'put',
      payload: boardLists.map(entry => entry.id)
    })
  },
  getBoardList (context, id) {
    return context.dispatch('get', {
      endpoint,
      resource: `board_lists/${id}`
    })
  },
  getBoardLists (context, projectId) {
    return context.dispatch('initCurrentUser').then(() => {
      if (!projectId) {
        let currentUser = context.getters.currentUser
        let project = currentUser.relationships['selected-project'].data
        projectId = project ? project.id : null
      }
      return context.dispatch('get', {
        endpoint,
        resource: `board_lists?filter[project_id]=${projectId}&include[]=issues`
      })
    })
  },
  updateBoardList (context, { entry, attributes }) {
    let payload = {
      id: entry.id,
      type: entry.type,
      attributes
    }
    return context.dispatch('update', { entry, payload, endpoint })
  },
  updateBoardListIssues (context, { boardList, issues }) {
    context.dispatch('changeManyToOneReference', {
      children: issues,
      parent: boardList,
      childRelationshipName: 'board-list',
      parentRelationshipName: 'issues',
      endpoint,
      parentTypes: ['board-lists']
    })
  }
}
