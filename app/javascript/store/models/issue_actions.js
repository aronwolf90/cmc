const endpoint = '/api/v1'

export default {
  initIssue (context, issueId) {
    return context.dispatch('initEntry', {
      endpoint,
      resource: `issues/${issueId}?include[]=comments`
    })
  },
  initIssues (context) {
    return context.dispatch('initEntry', {
      endpoint,
      resource: 'issues'
    })
  },
  initCurrentIssue () {

  },
  updateIssue (context, { entry, attributes, boardList }) {
    let payload = {
      id: entry.id,
      type: entry.type,
      attributes,
      relationships: { 'board-list': { data: boardList } }
    }
    return context.dispatch('update', { entry, payload, endpoint })
  },
  changeIssueToUserReference (context, { issue, user }) {
    context.dispatch('changeOneToManyReference', {
      child: issue,
      parent: user,
      childRelationshipName: 'user',
      parentRelationshipName: 'issues'
    })
  }
}
