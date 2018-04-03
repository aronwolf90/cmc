import Vue from 'vue'
import VueResource from 'vue-resource'

import Getters from '../../../../app/javascript/store/json_api/getters'

Vue.use(VueResource)

/* eslint-disable no-undef */

describe('Getters', () => {
  def('user', () => ({ id: '1', type: 'users' }))
  def('state', () => ({
    users: { 1: $user },
    meta: {
      users: { data: [{ id: '1', type: 'users' }] }
    }
  }))

  describe('#get', () => {
    describe('with the expected entry', () => {
      it('return the expected entry', () => {
        expect(Getters.get($state)({ type: 'users', id: '1' })).to.eql($user)
      })
    })

    describe('without the expected entry', () => {
      def('state', () => ({ }))

      it('return the expected entry', () => {
        expect(Getters.get($state)({ type: 'users', id: '1' })).to.eql(undefined)
      })
    })
  })
  describe('#getAll', () => {
    describe('with the coresponding collection', () => {
      it('return the expected collection', () => {
        expect(Getters.getAll($state)('users')).to.eql([$user])
      })
    })
    describe('without the coresponding collection', () => {
      def('state', () => ({ }))

      it('return an empty array', () => {
        expect(Getters.getAll($state)('users')).to.eql([])
      })
    })
  })
  describe('#getCollection', () => {
    describe('with the coresponding collection', () => {
      it('return the expected collection', () => {
        expect(Getters.getCollection($state)('users')).to.eql([$user])
      })
    })
    describe('without the coresponding collection', () => {
      def('state', () => ({ }))

      it('return undefined', () => {
        expect(Getters.getCollection($state)('users')).to.eql(undefined)
      })
    })
  })
  describe('#getMetaCollection', () => {
    describe('with the coresponding collection', () => {
      it('return the expected collection', () => {
        expect(Getters.getMetaCollection($state)('users')).to.eql([$user])
      })
    })
    describe('without the coresponding collection', () => {
      def('state', () => ({ }))

      it('return undefined', () => {
        expect(Getters.getMetaCollection($state)('users')).to.eql(undefined)
      })
    })
  })
  describe('#getAssociatedEntry', () => {
    describe('with the coresponding association entry', () => {
      it('return the expected entry', () => {
        let issue = { id: '1', type: 'issues', relationships: { user: { data: { id: '1', type: 'users' } } } }
        let state = { issue: { 1: issue }, users: { 1: $user } }

        expect(Getters.getAssociatedEntry(state)({entry: issue, name: 'user'})).to.eql($user)
      })
    })
    describe('without the coresponding association entry', () => {
      it('return undefined', () => {
        let issue = { id: '1', type: 'issues' }
        let state = { issue: { 1: issue } }

        expect(Getters.getAssociatedEntry(state)({entry: issue, name: 'user'})).to.eql(undefined)
      })
    })
  })
  describe('#getAssociatedEntries', () => {
    describe('with the coresponding associated collection', () => {
      it('return the expected collection', () => {
        let user = { id: '1', type: 'users' }
        let issue = { id: '1', type: 'issues', relationships: { users: { data: [{ id: '1', type: 'users' }] } } }
        let state = { issues: { 1: issue }, users: { 1: user } }
        expect(Getters.getAssociatedEntries(state)({entry: issue, name: 'users'})).to.eql([user])
      })
    })
    describe('without the coresponding associated collection', () => {
      it('return undefined', () => {
        let issue = { id: '1', type: 'issues' }
        let state = { issue: { 1: issue } }

        expect(Getters.getAssociatedEntries(state)({entry: issue, name: 'user'})).to.eql([])
      })
    })
  })
})
