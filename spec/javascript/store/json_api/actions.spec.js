import Vue from 'vue'
import VueResource from 'vue-resource'

import Actions from '../../../../app/javascript/store/json_api/actions'

import sinon from 'sinon'

Vue.use(VueResource)

describe("Actions", () => {
  describe("#initEntry", () => {
    describe('without loaded entry', () => {
      it("call Actions#add", () => {
        let url = '/api/v1/users/1'

        let context = {
          store: {

          },
          getters: {
            get({ type, id }) {
              if (type == 'users' && id == '1') return undefined
              else throw new Error("Invalid parameter")
            }
          },
          commit(method, params) {
            if (method == 'init' && params == 'users') {
              if (!context.store.users) context.store.users = []
            }
            else {
              throw new Error('Unspecified mutation')
            }
          },
          dispatch: sinon.spy()
        }

        Actions.initEntry(context, { url, id: '1', type: 'users' })

        expect(context.dispatch).to.have.been.calledWith('add', url);
      })
    })

    describe('without loaded entry', () => {
      it("not call Actions#add", () =>{
        let user = { id: '1', type: 'users' }
        let url = '/api/v1/users/1'

        let context = {
          store: {

          },
          getters: {
            get({ type, id }) {
              if (type == 'users' && id == '1') return user
              else throw new Error("Invalid parameter")
            }
          },
          commit(method, params) {
            if (method == 'init' && params == 'users') {
              if (!context.store.users) context.store.users = []
            }
            else {
              throw new Error('Unspecified mutation')
            }
          },
          dispatch: sinon.spy()
        }

        Actions.initEntry(context, { url, id: '1', type: 'users' })

        expect(context.dispatch).to.not.have.been.calledWith('add', url);
      })
    })
  })
  describe("#initCollection", () => {
    describe('without loaded entry', () => {
      describe('when no empty data is stored', () => {
        it("call Actions#addCollection", () => {
          let url = '/api/v1/users'

          let context = {
            state: {

            },
            getters: {
              getCollection(type) {
                if (type == 'users') return context.state.users
                else throw new Error("Invalid parameter")
              }
            },
            dispatch(method, parameter) {
              if (method == 'addCollection') {
                context.state.users = [{ id: '1', type: 'users' }]
              }
              else throw new Error("Invalid method")
            }
          }

          let dispatch_spy = sinon.spy(context, 'dispatch')

          Actions.initCollection(context, { url, type: 'users' })

          expect(dispatch_spy).to.have.been.calledWith('addCollection', url);
        })
      })
      describe('when no data is stored', () => {
        it("call Mutations#init", () => {
          let url = '/api/v1/users'

          let context = {
            state: {

            },
            getters: {
              getCollection(type) {
                if (type == 'users') return context.state.users
                else throw new Error("Invalid parameter")
              }
            },
            dispatch(method, parameter) {
              if (method != 'addCollection') throw new Error("Invalid method")
            },
            commit: sinon.spy()
          }

          Actions.initCollection(context, { url, type: 'users' })

          expect(context.commit).to.have.been.calledWith('init', 'users');
        })
      })
    })
    describe('without loaded entry', () => {
      it("not call Actions#add", () => {
        let user = { id: '1', type: 'users' }
        let url = '/api/v1/users'

        let context = {
          store: {

          },
          getters: {
            getCollection(type) {
              if (type == 'users') return [user]
              else throw new Error("Invalid parameter")
            }
          },
          commit(method, params) {
            if (method == 'init' && params == 'users') {
              if (!context.store.users) context.store.users = []
            }
            else {
              throw new Error('Unspecified mutation')
            }
          },
          dispatch: sinon.spy()
        }

        Actions.initCollection(context, { url, type: 'users' })

        expect(context.dispatch).to.not.have.been.calledWith('addCollection', url);
      })
    })
  })
  describe('#add', () => {
    it("call commit #add once", () => {
      let user = { id: '1', type: 'users' }
      let url = '/api/v1/users/1'

      let context = {
        store: {

        },
        commit: sinon.spy(),
        dispatch(method, { url, success_funtion }) {
          if (method == 'request') {
            success_funtion({
              data: {
                id: '1',
                type: 'users'
              }
            })
          }
          else {
            throw new Error('Unspecified action')
          }
        }
      }

      Actions.add(context, { url, type: 'users' })

      expect(context.commit).to.have.been.calledWith('add', { id: '1', type: 'users'});
    })
    it("call commit #add two times (one for the root and one for the included)", () => {
      let user = { id: '1', type: 'users' }
      let comment = { id: 1, type: 'comments' }
      let url = '/api/v1/users/1'

      let context = {
        state: {

        },
        getters: {
          getCollection(type) {
            if (type == 'users') return [user]
            else if (type == 'comments') return undefined
            else throw new Error("Invalid parameter")
          }
        },
        commit: sinon.spy(),
        dispatch(method, { url, success_funtion }) {
          if (method == 'request') {
            success_funtion({
              data: user,
              included: [comment]
            })
          }
          else {
            throw new Error('Unspecified action')
          }
        }
      }

      Actions.add(context, { url, type: 'users' })

      expect(context.commit).to.have.been.calledWithMatch('add', user)
      expect(context.commit).to.have.been.calledWithMatch('add', comment)
    })
  })
  describe('#addCollection', () => {
    it("call commit #add once", () => {
      let user = { id: '1', type: 'users' }
      let url = '/api/v1/users'

      let context = {
        state: {

        },
        commit: sinon.spy(),
        dispatch(method, { url, success_funtion }) {
          if (method == 'request') {
            success_funtion({
              data: [user]
            })
          }
          else {
            throw new Error('Unspecified action')
          }
        }
      }

      Actions.addCollection(context, 'users')

      expect(context.commit).to.have.been.calledWith('add', { id: '1', type: 'users'});
    })
    it("call commit #add two times (one for the root and one for the included)", () => {
      let user = { id: '1', type: 'users' }
      let comment = { id: 1, type: 'comments' }
      let url = '/api/v1/users/1'

      let context = {
        state: {

        },
        getters: {
          getCollection(type) {
            if (type == 'users') return [user]
            else if (type == 'comments') return undefined
            else throw new Error("Invalid parameter")
          }
        },
        commit: sinon.spy(),
        dispatch(method, { url, success_funtion }) {
          if (method == 'request') {
            success_funtion({
              data: [user],
              included: [comment]
            })
          }
          else {
            throw new Error('Unspecified action')
          }
        }
      }

      Actions.addCollection(context, { url, type: 'users' })

      expect(context.commit).to.have.been.calledWithMatch('add', user)
      expect(context.commit).to.have.been.calledWithMatch('add', comment)
    })
  })
  describe('#request', (done) => {
    it('call the respose function with the ajax response as parameter', () => {
      let data = { data: { id: '1', type: 'users' } }
      let url = '/api/v1/users/1'

      let server = sinon.fakeServer.create()
      server.respondWith('GET', url, [
        200, {"Content-Type":"application/json"}, JSON.stringify({ data: data })
      ]);

      Actions.request({}, { url, success_funtion: (response) => {
        expect(response).to.eql(data)
        done()
      }})

      server.respond()

      server.restore()
    })
  })
  describe('#changeRelationship', () => {
    it('change coresponding relationships', (done) => {
      let issue = {
        id: '1',
        type: 'issues'
      }
      let comment = {
        id: '1',
        type: 'comments',
      }
      let url = '/comments/1'

      context = {
        state: {
          issues: [issue],
          comments: [comment]
        },
        dispatch: (method, param) => {
          if (method == 'request') param.success_funtion()
          else throw new Error('Unspecified action')
        },
        commit: (method, param) => {
          if (method == 'removeFromAll') {}
          else if (method == 'addToMultiple') {
            issue.relationships = { comments: { data: [{ id: '1', type: 'users' }] } }
          }
          else if (method == 'setAssociation') {
            comment.relationships = { issue: { data: { id: '1', type: 'comments' } } }
          }
          else throw new Error('Unspecified action')
        }
      }

      Actions.changeRelationship(context, {
        child: comment,
        parent: issue,
        parent_relationship_name: 'issues',
        child_relationship_name: 'user',

        data: { id: '1', type: '' },
        func_success: () => {
          expect(issue.relationships.comments.data).to.eql([{ id: '1', type: 'users' }])
          expect(comment.relationships.issue.data).to.eql({ id: '1', type: 'comments' })
          done()
        }
      })
    })
  })
  describe('#changeOneToManyReference', () => {
    it("call dispatch #changeRelationship once", () => {
      let issue = {
        id: '1',
        type: 'issues',
        links: { self: '/issues/1' }
      }
      let comment = {
        id: '1',
        type: 'comments',
        links: { self: '/comments/1' }
      }
      let url = '/comments/1'

      let context = {
        state: {
          issues: [issue],
          comments: [comment]
        },
        dispatch: sinon.spy()
      }

      Actions.changeOneToManyReference(context, {
        child: comment,
        parent: issue,
        parent_relationship_name: 'comments',
        child_relationship_name: 'issue'
      })

      expect(context.dispatch).to.have.been.calledWith('changeRelationship', {
        child: comment,
        parent: issue,
        parent_relationship_name: 'comments',
        child_relationship_name: 'issue',
        func_success: undefined,
        url,
        data: { id: issue.id, type: issue.type }
      })
    })
  })
  describe('#create', () => {
    it("call func_success with the corespondig created entry", (done) => {
      let issue = {
        id: '1',
        type: 'issues',
        links: { self: '/issues/1' }
      }
      let comment = {
          attributes: { content: 'hi' },
          relationships: { issue: { data: { id: '1', type: 'issues' }}}
      }
      let url = '/comments/1'

      let context = {
        state: {
          issues: [issue]
        },
        dispatch: (method, params) => {
          if (method == 'request') {
            return params.success_funtion({ data: comment })
          }
          else throw new Error('Unspecified action')
        },
        commit: (method, params) => {
          if (method == 'add') {
            if (!context.state.comments) context.state.comments = []
            context.state.comments.push(params)
          }
          else throw new Error('Unspecified mutation')
        },
        getters: { get: (params) => {
          return () => { return context.state.comments[0] }
        }}
      }

      Actions.create(context, { url, payload: { data: comment }, func_success: (response) => {
        expect(context.state.comments[0]).to.eql(comment)
        done()
      }})
    })
  })
})
