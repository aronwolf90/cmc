import MetaCollectionService from '../../../../../../app/javascript/store/json_api/services/getters/meta_collection_service'

/* eslint-disable no-undef */

describe('MetaCollectionService', () => {
  subject(() => new MetaCollectionService({ state: $state, name: 'users' }))

  def('userRef', () => ({ id: 1, type: 'users' }))
  def('user', () => ({ id: 1, type: 'users', attributes: { test: 'test' } }))

  describe('when no meta data is present', () => {
    def('state', () => ({ }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql(undefined)
    })
  })
  describe('when the meta is present but not the indicated resource', () => {
    def('state', () => ({ meta: {} }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql(undefined)
    })
  })

  describe('when the meta resource is prsent but not the data field', () => {
    def('state', () => ({ meta: { 'users': {} } }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql(undefined)
    })
  })

  describe('when the meta resource is avaiable but not the resource itself', () => {
    def('state', () => ({
      users: { 1: $user },
      meta: { 'users': { data: [$userRef] } }
    }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql([$user])
    })
  })
})
