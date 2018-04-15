const endpoint = '/api/v1'

export default {
  initIssue (context, issueId) {
    return context.dispatch('initEntry', { endpoint, resource: `issues/${issueId}` })
  },
  initIssues (context) {
    return context.dispatch('initEntry', { endpoint, resource: `issues` })
  },
  initCurrentIssue () {

  },
  updateIssue (context, { entry, attributes }) {
    let payload = {
      id: entry.id,
      type: entry.type,
      attributes
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
