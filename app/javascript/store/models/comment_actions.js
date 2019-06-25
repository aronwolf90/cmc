import { Utils } from 'vuex-jsonapi-client'

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
    }).then(response => {
      context.commit('addToMultiple', {
        parent: issue,
        child: response.data,
        relationshipName: 'comments'
      })
      context.commit('addToMultiple', {
        parent: user,
        child: response.data,
        relationshipName: 'comments'
      })
      return response.data
    })
  }
}
