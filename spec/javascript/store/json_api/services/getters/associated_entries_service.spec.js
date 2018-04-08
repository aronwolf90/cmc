import AssociatedEntriesService from '../../../../../../app/javascript/store/json_api/services/getters/associated_entries_service'

/* eslint-disable no-undef */

describe('AssociatedEntriesService', () => {
  subject(() => new AssociatedEntriesService({ state: $state, entry: $issue, name: 'users' }))

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
    def('relationships', () => ({ users: { data: [$user] } }))

    it('return the related collection', () => {
      expect($subject.perform()).to.eql([$user])
    })
  })
})
