import Vue from 'vue'
import VueResource from 'vue-resource'

import ChangeManyToOneReferenceService from '../../../../../../app/javascript/store/json_api/services/mutations/change_many_to_one_reference_service'

Vue.use(VueResource)

/* eslint-disable no-undef */

describe('ChangeManyToOneReferenceService', () => {
  def('issue1', () => ({
    id: '1',
    type: 'issues',
    relationships: { user: { data: { id: '1', type: 'users' } } }
  }))
  def('issue2', () => ({
    id: '2',
    type: 'issues',
    relationships: { user: { data: { id: '1', type: 'users' } } }
  }))
  def('user1', () => ({
    id: '1',
    type: 'users',
    relationships: { issues: { data: [$issue1, $issue2] } }
  }))
  def('user2', () => ({ id: '2', type: 'users' }))
  def('state', () => ({
    issues: { 1: $issue1, 2: $issue2 },
    users: { 1: $user1, 2: $user2 }
  }))

  beforeEach(() => {
    new ChangeManyToOneReferenceService({
      state: $state,
      parent: $user2,
      children: [$issue1, $issue2],
      parentTypes: ['users'],
      parentRelationshipName: 'issues',
      childRelationshipName: 'user'
    }).perform()
  })

  it('remove from old parent', () => {
    expect($user1.relationships.issues.data).to.eql([])
  })
  it('assigen to the new parent', () => {
    expect($user2.relationships.issues.data).to
      .eql([{ id: '1', type: 'issues' }, { id: '2', type: 'issues' }])
  })
})
