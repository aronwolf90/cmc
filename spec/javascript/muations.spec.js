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
    });
  });

  describe("#add", () => {
    it("add an entry to the collection", () => {
      let store = { users: [] }
      let user = { id: 1, type: 'users' }

      Mutations.add(store, user)

      expect(store.users).to.eql([user])
    })
  })

  describe("#update", () => {
    it("change an attribute", () => {
      let user_old = { id: 1, type: 'users', attributes: { name: 'name before', attr: 'attr' } }
      let user_new = { id: 1, type: 'users', attributes: { name: 'name after', attr: 'attr' } }
      let user_delta = { id: 1, type: 'users', attributes: { name: 'name after' } }
      let store = { users: [user_old] }

      Mutations.update(store, { entry: user_old, payload: user_delta })

      expect(store.users).to.eql([user_new])
    })

    it("change an has_one link", () => {
      let user_old = { id: 1, type: 'users', links: { issue: { data: { id: 1, type: 'issues' } } } }
      let user_new = { id: 1, type: 'users', links: { issue: { data: { id: 2, type: 'issues' } } } }
      let user_delta = { id: 1, type: 'users', links: { issue: { data: { id: 2, type: 'issues' } } } }
      let store = { users: [user_old] }

      Mutations.update(store, { entry: user_old, payload: user_delta })

      expect(store.users).to.eql([user_new])
    })

    it("change an has_one link", () => {
      let user_old = { id: 1, type: 'issues', links: { issue: { data: [ { id: 1, type: 'comments' } ] } } }
      let user_new = { id: 1, type: 'issues', links: { issue: { data: [ { id: 2, type: 'comments' } ] } } }
      let user_delta = { id: 1, type: 'issues', links: { issue: { data: [ { id: 2, type: 'comments' } ] } } }
      let store = { users: [user_old] }

      Mutations.update(store, { entry: user_old, payload: user_delta })

      expect(store.users).to.eql([user_new])
    })
  })

  describe("#remove", function() {
    it("remove entry from collection", function() {
      let user = { id: 1, type: 'users' }
      let store = { users: [user] }

      Mutations.remove(store, user)

      expect(store.users).to.eql([])
    });
  })

  describe("#removeFromAll", function() {
    it("remove from assotiation", function() {
      let comment = { id: 1, type: 'comments' }
      let issue = { id: 1, type: 'issues', relationships: {
        comments: { data: [ comment ] }
      }}
      let store = { issues: [issue] }

      Mutations.removeFromAll(store, {
        child: comment, parent: issue, parent_relationship_name: 'comments'
      })

      expect(store.issues[0].relationships.comments.data).to.eql([])
    });
  })

  describe("#addToMultiple", function() {
    it("add to assotiation", function() {
      let comment = { id: 1, type: 'comments' }
      let issue = { id: 1, type: 'issues', relationships: {
        comments: { data: [] }
      }}
      let state = { issues: [issue] }

      Mutations.addToMultiple(state, {
        parent: issue, child: comment, relationship_name: 'comments'
      })

      expect(state.issues[0].relationships.comments.data).to.eql([comment])
    });
  })

  describe("#setAssotiation", function() {
    it("add to assotiation", function() {
      let user = { id: 1, type: 'users' }
      let issue = { id: 1, type: 'issues', relationships: {
        user: { data: {} }
      }}
      let state = { issues: [issue] }

      Mutations.setAssotiation(state, {
        parent: issue, child: user, relationship_name: 'user'
      })

      expect(state.issues[0].relationships.user.data).to.eql(user)
    });
  })
})
