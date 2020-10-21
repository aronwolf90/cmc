import { mount, createLocalVue } from '@vue/test-utils'
import Issue from '../../app/javascript/issue'
import Vuex from 'vuex'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Issue', () => {
  subject(() => mount(Issue, {
    store: $store,
    localVue,
    propsData: { id: 1 },
    stubs: {
      RightAside: '<div>Stubbed RightAside</div>',
      Comments: '<div>Stubbed Comments</div>',
      CreatedBy: true
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
