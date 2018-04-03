import Vue from 'vue'
import VueResource from 'vue-resource'

import Actions from '../../../../app/javascript/store/json_api/actions'

import sinon from 'sinon'
import sinonStubPromise from 'sinon-stub-promise'

/* eslint-disable no-undef */

Vue.use(VueResource)
sinonStubPromise(sinon)

describe('Actions', () => {
  def('user_url', () => '/api/v1/users/1')
  def('users_url', () => '/api/v1/users')
  def('user', () => ({
    id: '1',
    type: 'users',
    relationships: { issues: $issue },
    links: { self: $user_url }
  }))
  def('issue', () => ({ id: '1', type: 'issue' }))
  def('userResponse', () => ({
    data: $user,
    included: [ $issue ]
  }))
  def('usersResponse', () => ({
    data: [ $user ],
    included: [ $issue ]
  }))
  def('wasUrlCalled', () => () => false)
  def('urlPromise', () => { return sinon.stub().returnsPromise() })
  def('getters', () => ({
    get: () => $user,
    getCollection: () => [$user],
    wasUrlCalled: $wasUrlCalled,
    getPromiseByUrl: $urlPromise
  }))
  def('commit', () => sinon.spy())
  def('dispatch', () => sinon.spy())
  def('context', () => ({
    getters: $getters,
    commit: $commit,
    dispatch: $dispatch
  }))

  describe('#initEntry', () => {
    describe('when the url has not be called before', () => {
      it('call Actions#add', () => {
        Actions.initEntry($context, { endpoint: 'api/v1', resource: 'users' })
        expect($context.dispatch).to.have.been.calledWith('add', {
          endpoint: 'api/v1', resource: 'users', url: 'api/v1/users' })
      })
    })

    describe('when the url has be called before', () => {
      def('wasUrlCalled', () => () => true)
      beforeEach(() => $urlPromise.resolves($user))

      it('not call Actions#add', () => {
        Actions.initEntry($context, { endpoint: 'api/v1', resource: 'users' })
        expect($context.dispatch).to.not.have.been.calledWith('add', {
          endpoint: 'api/v1', resource: 'users' })
      })
    })
  })
  describe('#add', () => {
    def('request', () => sinon.stub().returnsPromise())
    def('dispatch', () => {
      return sinon.stub().withArgs('request', { url: $user_url })
        .returns($request())
    })
    beforeEach(() => $request.resolves($userResponse))

    it('call commit #addByNormalize', () => {
      Actions.add($context, { endpoint: 'api/v1', resource: 'users' })
      expect($context.commit).to.have.been.calledWith('addByNormalize', {
        payload: $userResponse, resource: 'users'
      })
    })
  })
  describe('#request', (done) => {
    def('server', () => sinon.fakeServer.create())
    beforeEach(() => {
      $server.respondWith('GET', $user_url, [
        200, { 'Content-Type': 'application/json' },
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
