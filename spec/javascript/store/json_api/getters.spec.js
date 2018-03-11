import Vue from 'vue'
import VueResource from 'vue-resource'

import Getters from '../../../../app/javascript/store/json_api/getters'

Vue.use(VueResource)

describe('Getters', () => {
  describe('#get', function() {
    describe('with the expected entry', () => {
      it('return the expected entry', () => {
        let user = { id: '1', type: 'users' }
        let state = { users: [ user ] }

        expect(Getters.get(state)({ type: 'users', id: '1' })).to.eql(user)
      })
    })

    describe('without the expected entry', () => {
      it('return the expected entry', () => {
        let state = { }

        expect(Getters.get(state)({ type: 'users', id: '1' })).to.eql(undefined)
      })
    })
  })
  describe("#getAll", () => {
    describe("with the coresponding collection", () => {
      it("return the expected collection", () => {
        let user = { id: '1', type: 'users' }
        let state = { users: [ user ] }

        expect(Getters.getAll(state)('users')).to.eql([user])
      })
    })
    describe("without the coresponding collection", () => {
      it("return an empty array", () => {
        let state = { }

        expect(Getters.getAll(state)('users')).to.eql([])
      })
    })
  })
  describe("#getCollection", () => {
    describe("with the coresponding collection", () => {
      it("return the expected collection", () => {
        let user = { id: '1', type: 'users' }
        let state = { users: [ user ] }

        expect(Getters.getCollection(state)('users')).to.eql([user])
      })
    })
    describe("without the coresponding collection", () => {
      it("return undefined", () => {
        let state = { }

        expect(Getters.getCollection(state)('users')).to.eql(undefined)
      })
    })
  })
  describe("#getAssociatedEntry", () => {
    describe("with the coresponding association entry", () => {
      it("return the expected entry", () => {
        let user = { id: '1', type: 'users' }
        let issue = { id: '1', type: 'issues', relationships: { user: { data: { id: '1', type: 'users' } } } }
        let state = { issue: [ issue ], users: [ user ] }

        expect(Getters.getAssociatedEntry(state)({entry: issue, name: 'user'})).to.eql(user)
      })
    })
    describe("without the coresponding association entry", () => {
      it("return undefined", () => {
        let issue = { id: '1', type: 'issues' }
        let state = { issue: [ issue ] }

        expect(Getters.getAssociatedEntry(state)({entry: issue, name: 'user'})).to.eql(undefined)
      })
    })
  })
  describe("#getAssociatedEntries", () => {
    describe("with the coresponding associated collection", () => {
      it("return the expected collection", () => {
        let user = { id: '1', type: 'users' }
        let issue = { id: '1', type: 'issues', relationships: { users: { data: [{ id: '1', type: 'users' }] } } }
        let state = { issues: [ issue ], users: [ user ] }
        expect(Getters.getAssociatedEntries(state)({entry: issue, name: 'users'})).to.eql([user])
      })
    })
    describe("without the coresponding associated collection", () => {
      it("return undefined", () => {
        let issue = { id: '1', type: 'issues' }
        let state = { issue: [ issue ] }

        expect(Getters.getAssociatedEntries(state)({entry: issue, name: 'user'})).to.eql([])
      })
    })
  })
})
