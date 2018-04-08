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

  describe('#entry', () => {
    describe('with the expected entry', () => {
      it('return the expected entry', () => {
        expect(Getters.entry($state)({ type: 'users', id: '1' })).to.eql($user)
      })
    })

    describe('without the expected entry', () => {
      def('state', () => ({ }))

      it('return the expected entry', () => {
        expect(Getters.entry($state)({ type: 'users', id: '1' })).to.eql(undefined)
      })
    })
  })
  describe('#collection', () => {
    describe('with the coresponding collection', () => {
      it('return the expected collection', () => {
        expect(Getters.collection($state)('users')).to.eql([$user])
      })
    })
    describe('without the coresponding collection', () => {
      def('state', () => ({ }))

      it('return undefined', () => {
        expect(Getters.collection($state)('users')).to.eql(undefined)
      })
    })
  })
})
