import Vue from 'vue'
import VueResource from 'vue-resource'

import Actions from '../../../../app/javascript/store/json_api/actions'

import sinon from "sinon"
import sinonStubPromise from "sinon-stub-promise"

Vue.use(VueResource)
sinonStubPromise(sinon);

describe("Actions", () => {
  def("user_url", () => "/api/v1/users/1" )
  def("users_url", () => "/api/v1/users" )
  def("user", () => { return {
    id: "1",
    type: "users",
    relationships: { issues: $issue },
    links: { self: $user_url }
  } } )
  def("issue", () => { return { id: "1", type: "issue" }  })
  def("userResponse", () => { return {
    data: $user,
    included: [ $issue ]
  } })
  def("usersResponse", () => { return {
    data: [ $user ],
    included: [ $issue ]
  } })
  def("wasUrlCalled", () => () => false )
  def("urlPromise", () => { return sinon.stub().returnsPromise() } )
  def("getters", () => { return {
    get: () => $user,
    getCollection: () => [$user],
    wasUrlCalled: $wasUrlCalled,
    getPromiseByUrl: $urlPromise
  } } )
  def("commit", () => sinon.spy() )
  def("dispatch", () => sinon.spy() )
  def("context", () => { return {
    getters: $getters,
    commit: $commit,
    dispatch: $dispatch
  } })

  describe("#initEntry", () => {
    describe("when the url has not be called before", () => {
      it("call Actions#add", () => {
        Actions.initEntry($context, $user_url)
        expect($context.dispatch).to.have.been.calledWith('add', $user_url)
      })
    })

    describe("when the url has be called before", () => {
      def("wasUrlCalled", () => () => true)
      beforeEach(() => $urlPromise.resolves($user))

      it("not call Actions#add", () =>{
        Actions.initEntry($context, $user_url)
        expect($context.dispatch).to.not.have.been.calledWith('add', $user_url)
      })
    })
  })
  describe("#initCollection", () => {
    describe('when the url has not be called before', () => {
      it("call Actions#addCollection", () => {
        Actions.initCollection($context, $users_url)
        expect($context.dispatch).to.have.been.calledWith('addCollection', $users_url);
      })
    })
    describe('without loaded entry', () => {
      def("wasUrlCalled", () => () => true)

      it("not call Actions#addCollection", () => {
        Actions.initCollection($context, $users_url)
        expect($context.dispatch).to.not.have.been.calledWith('addCollection', $users_url);
      })
    })
  })
  describe('#add', () => {
    def("request", () => sinon.stub().returnsPromise())
    def("dispatch", () => {
      return sinon.stub().withArgs("request", { url: $user_url })
                  .returns($request())
    })
    beforeEach(() => $request.resolves($userResponse))

    it("call commit #add with user", () => {
      Actions.add($context, $user_url)
      expect($context.commit).to.have.been.calledWith('add', $user)
    })
    it("call commit #add with issue", () => {
      Actions.add($context, $user_url)
      expect($context.commit).to.have.been.calledWith('add', $issue)
    })
  })
  describe('#addCollection', () => {
    def("request", () => sinon.stub().returnsPromise())
    def("dispatch", () => {
      return sinon.stub().withArgs("request", { url: $users_url })
                  .returns($request())
    })
    beforeEach(() => $request.resolves($usersResponse))

    it("call user #add", () => {
      Actions.addCollection($context, $users_url)
      expect($context.commit).to.have.been.calledWith('add', $user)
    })
    it("call user #add", () => {
      Actions.addCollection($context, $users_url)
      expect($context.commit).to.have.been.calledWith('add', $issue)
    })
  })
  describe('#request', (done) => {
    def("server", () => sinon.fakeServer.create())
    beforeEach(() => {
      $server.respondWith('GET', $user_url, [
        200, {"Content-Type":"application/json"},
        JSON.stringify($userResponse)
      ])
    })

    it('return a a promise froma http request', (done) => {
      Actions.request($context, { url: $user_url }).then(response => {
        expect(response).to.eql($userResponse)
        done()
      })

      $server.respond()
      $server.restore()
    })
  })
})
