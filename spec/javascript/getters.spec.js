import Vue from 'vue'
import VueResource from 'vue-resource'

import Mutations from '../../app/javascript/store/json_api/mutations'

Vue.use(VueResource)

describe("Mutations", function() {
  describe("#init", function() {
    it("init with empty array the collection", function() {
      let store = {}
      Mutations.init(store, 'users')

      expect(store.users).to.eql([])
    })
  })
})
