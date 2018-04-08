import Vue from 'vue'
import VueResource from 'vue-resource'

import RemoveFromAllService from '../../../../../../app/javascript/store/json_api/services/mutations/remove_from_all_service'

Vue.use(VueResource)

/* eslint-disable no-undef */

describe('RemoveFromAll', () => {
  def('user', () => ({
    id: '1',
    type: 'users',
    relationships: {
      issues: { data: [{ id: '1', type: 'issues' }] }
    }
  }))
  def('issue', () => ({ id: '1', type: 'issues' }))
  def('state', () => ({ issues: { 1: $issue }, users: { 1: $user } }))

  it('remove from assotiation', () => {
    new RemoveFromAllService({
      state: $state,
      child: $issue,
      parentType: 'users',
      parentRelationshipName: 'issues'
    }).perform()

    expect($state.users['1'].relationships.issues.data).to.eql([])
  })
})
