import { mount, createLocalVue } from '@vue/test-utils'
import Issue from '../../app/javascript/issue'
import Vuex from 'vuex'
import VueRouter from 'vue-router'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Issue', () => {
  subject(() => mount(Issue, {
    store: $store,
    localVue,
    propsData: { issueId: 1 },
    stubs: {
      RightAside: '<div>Stubbed RightAside</div>',
      Comments: '<div>Stubbed Comments</div>'
    }
  }))

  def('getters', () => ({
    entry () { return () => $issue }
  }))
  def('actions', () => ({ initIssue () { } }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('issue', () => ({
    id: 1,
    type: 'issues',
    attributes: { title: 'issue title', description: 'description' }
  }))

  it('has comments', () => {
    expect($subject.html()).to.include('Stubbed Comments')
  })

  it('has right asigen', () => {
    expect($subject.html()).to.include('Stubbed RightAside')
  })
})
