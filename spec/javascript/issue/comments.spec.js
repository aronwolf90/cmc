import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Comments from '../../../app/javascript/issue/comments'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Comments', () => {
  subject(() => shallow(Comments, { store: $store, localVue }))

  def('getters', () => ({
    entry () { return () => $issue },
    associatedEntries () { return () => $comments }
  }))
  def('actions', () => ({ initIssue () { return $sinonPromise }, updateIssue () { return $sinonPromise } }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))

  describe('with resolved promise', () => {
    def('comments', () => [$comment])
    def('comment', () => ({
      id: 1,
      type: 'comments',
      attributes: { content: 'comment content' }
    }))
    def('issue', () => ({
      id: 1,
      type: 'issues',
      attributes: { title: 'issue title', description: 'description' }
    }))

    it('contain comment', () => {
      expect($subject.html()).to.include('comment content')
    })
  })
})
