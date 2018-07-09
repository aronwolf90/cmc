const endpoint = '/api/v1'

export default {
  initUserIssuesForCurrentUser (context) {
    return context.dispatch('initCurrentUser').then(currentUser => {
      return context.dispatch('initEntry', {
        endpoint,
        resource: `user_issues?filter[user_id]=${currentUser.id}`
      })
    })
  }
}
