import * as Utils from '../json_api/utils'

const endpoint = '/api/v1'

export default {
  createComment (context, { issue, user, attributes }) {
    let payload = {
      attributes,
      'relationships': {
        'issue': { 'data': Utils.entryToRef(issue) },
        'user': { 'data': Utils.entryToRef(user) }
      }
    }

    context.dispatch('create', {
      resource: `comments`,
      endpoint,
      payload
    }).then(comment => {
      context.commit('addToMultiple', {
        parent: issue,
        child: comment,
        relationshipName: 'comments'
      })
      context.commit('addToMultiple', {
        parent: user,
        child: comment,
        relationshipName: 'comments'
      })
      return comment
    })
  }
}
