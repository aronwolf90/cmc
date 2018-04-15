import { shallow, createLocalVue } from '@vue/test-utils'
import Issue from '../../app/javascript/issue'
import Vuex from 'vuex'
import VueRouter from 'vue-router'
import Comments from '../../app/javascript/issue/comments'
import Assigen from 'issue/assigen'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Issue', () => {
  subject(() => shallow(Issue, { store: $store, localVue, propsData: { issueId: 1 } }))

  def('getters', () => ({ entry () { return () => $issue } }))
  def('actions', () => ({ initIssue () { } }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('issue', () => ({
    id: 1,
    type: 'issues',
    attributes: { title: 'issue title', description: 'description' }
  }))

  it('has comments', () => {
    expect($subject.find(Comments).props().issueId).to.be.eq(1)
  })

  it('has assigen', () => {
    expect($subject.find(Assigen).props().issueId).to.be.eq(1)
  })
})
