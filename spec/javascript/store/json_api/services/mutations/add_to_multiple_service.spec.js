import Vue from 'vue'
import VueResource from 'vue-resource'

import AddToMultipleService from '../../../../../../app/javascript/store/json_api/services/mutations/add_to_multiple_service'

Vue.use(VueResource)

/* eslint-disable no-undef */

describe('AddToMultipleService', () => {
  def('comment', () => ({ id: '1', type: 'comments' }))
  def('issue', () => ({
    id: '1',
    type: 'issues',
    relationships: { comments: { data: [] } }
  }))

  it('add to assotiation', () => {
    new AddToMultipleService({
      parent: $issue,
      child: $comment,
      relationshipName: 'comments'
    }).perform()

    expect($issue.relationships.comments.data).to.eql([$comment])
  })
})
