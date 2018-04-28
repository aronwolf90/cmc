import AssociatedEntryService from '../../../../../../app/javascript/store/json_api/services/getters/associated_entry_service'

/* eslint-disable no-undef */

describe('AssociatedEntryService', () => {
  subject(() => new AssociatedEntryService({ state: $state, entry: $issue, name: 'user' }))

  def('state', () => ({ users: { 1: $user } }))
  def('userRef', () => ({ id: 1, type: 'users' }))
  def('user', () => ({ id: 1, type: 'users', attributes: { test: 'test' } }))
  def('issue', () => ({
    id: '1',
    type: 'users',
    relationships: $relationships
  }))

  describe('when the relationships on the entry is undefined', () => {
    def('relationships', () => undefined)

    it('return undefined', () => {
      expect($subject.perform()).to.eql(undefined)
    })
  })

  describe('when the association is not present', () => {
    def('relationships', () => ({}))

    it('return undefined', () => {
      expect($subject.perform()).to.eql(undefined)
    })
  })

  describe('when the relationship is present', () => {
    def('relationships', () => ({ user: { data: $userRef } }))

    it('return the related collection', () => {
      expect($subject.perform()).to.eql($user)
    })
  })
})
