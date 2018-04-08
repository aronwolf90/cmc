const endpoint = '/api/v1'

export default {
  initBoardsLists (context) {
    return context.dispatch('initEntry', { endpoint, resource: 'board_lists' })
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
      endpoint
    })
  }
}
