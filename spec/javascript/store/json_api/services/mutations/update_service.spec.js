import Vue from 'vue'
import VueResource from 'vue-resource'

import UpdateService from '../../../../../../app/javascript/store/json_api/services/mutations/update_service'

Vue.use(VueResource)

/* eslint-disable no-undef */

describe('UpdateService', () => {
  beforeEach(() => { new UpdateService({ entry: $oldUser, payload: $deltaUser }).perform() })

  describe('with changed attribute', () => {
    def('oldUser', () => ({ id: 1, type: 'users', attributes: { name: 'name before', attr: 'attr' } }))
    def('newUser', () => ({ id: 1, type: 'users', attributes: { name: 'name after', attr: 'attr' } }))
    def('deltaUser', () => ({ id: 1, type: 'users', attributes: { name: 'name after' } }))

    it('change the attribute', () => {
      expect($oldUser).to.eql($newUser)
    })
  })

  describe('with changed hasOne relationship', () => {
    def('oldUser', () => ({ id: 1, type: 'users', relationships: { issue: { data: { id: 1, type: 'issues' } } } }))
    def('newUser', () => ({ id: 1, type: 'users', relationships: { issue: { data: { id: 2, type: 'issues' } } } }))
    def('deltaUser', () => ({ id: 1, type: 'users', relationships: { issue: { data: { id: 2, type: 'issues' } } } }))

    it('change an hasOne relationship', () => {
      expect($oldUser).to.eql($newUser)
    })
  })
})
