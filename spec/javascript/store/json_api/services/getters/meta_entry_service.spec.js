import Vue from 'vue'
import VueResource from 'vue-resource'

import MetaEntryService from '../../../../../../app/javascript/store/json_api/services/getters/meta_entry_service'

Vue.use(VueResource)

/* eslint-disable no-undef */

describe('MetaEntryService', () => {
  subject(() => new MetaEntryService({ state: $state, name: 'users/1' }))

  def('userRef', () => ({ id: 1, type: 'users' }))
  def('user', () => ({ id: 1, type: 'users', attributes: { test: 'test' } }))

  describe('when no meta data s present', () => {
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
    def('state', () => ({ meta: { 'users/1': {} } }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql(undefined)
    })
  })

  describe('when the meta resource is avaiable but not the resource itself', () => {
    def('state', () => ({
      users: { 1: $user },
      meta: { 'users/1': { data: $userRef } }
    }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql($user)
    })
  })
})
