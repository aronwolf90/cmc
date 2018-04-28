import Vue from 'vue'
import VueResource from 'vue-resource'

import ClearService from '../../../../../../app/javascript/store/json_api/services/mutations/clear_service'

Vue.use(VueResource)

/* eslint-disable no-undef */

describe('ClearService', () => {
  beforeEach(() => { new ClearService({ state: $state, exclude: $exclude }).perform() })

  describe('when the store contain data and no config', () => {
    def('state', () => ({ users: [] }))
    def('exclude', () => undefined)

    it('remove all data from the store', () => {
      expect($state).to.eql({})
    })
  })

  describe('when the store contain data and config', () => {
    def('state', () => ({ users: [], config: { page: 1 } }))
    def('exclude', () => undefined)

    it('remove all data from the store', () => {
      expect($state).to.eql({ config: { page: 1 } })
    })
  })
})
