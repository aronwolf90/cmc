import Vue from 'vue'
import VueResource from 'vue-resource'

import RemoveService from '../../../../../../app/javascript/store/json_api/services/mutations/remove_service'

Vue.use(VueResource)

/* eslint-disable no-undef */

describe('RemoveService', () => {
  describe('when entry ', () => {
    def('entry', () => ({ id: '1', type: 'users' }))
    def('state', () => ({
      meta: {
        '/users/1': {
          id: '1',
          type: 'users'
        },
        '/users/2': {
          id: '2',
          type: 'users'
        },
        '/users': [{
          id: '1',
          type: 'users'
        }, {
          id: '2',
          type: 'users'
        }]
      },
      users: {
        1: {
          id: '1',
          type: 'users'
        },
        2: {
          id: '2',
          type: 'users'
        }
      }
    }))

    def('expectedResult', () => ({
      meta: {
        '/users/2': {
          id: '2',
          type: 'users'
        },
        '/users': [{
          id: '2',
          type: 'users'
        }]
      },
      users: {
        2: {
          id: '2',
          type: 'users'
        }
      }
    }))

    it('Remove the data correctly', () => {
      new RemoveService({
        state: $state,
        entry: $entry
      }).perform()

      expect($state).to.eql($expectedResult)
    })
  })
})
