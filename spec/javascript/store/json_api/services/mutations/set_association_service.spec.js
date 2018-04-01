import Vue from 'vue'
import VueResource from 'vue-resource'

import SetAssociationService from '../../../../../../app/javascript/store/json_api/services/mutations/set_association_service'

Vue.use(VueResource)

/* eslint-disable no-undef */

describe('SetAssociationService', () => {
  def('user', () => ({ id: 1, type: 'users' }))
  def('issue', () => ({ id: 1, type: 'issues' }))

  it('add to association', () => {
    new SetAssociationService({
      parent: $user,
      child: $issue,
      relationshipName: 'user'
    }).perform()

    expect($issue.relationships.user.data).to.eql($user)
  })
})
