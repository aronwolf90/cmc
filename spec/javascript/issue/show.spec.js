import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Show from '../../../app/javascript/issue/show'
import MarkdownViewer from '../../../app/javascript/markdown_viewer'
import Button from 'bootstrap-vue/es/components/button/button'
import sinon from 'sinon'
import VueRouter from 'vue-router'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(VueRouter)
localVue.component('b-button', Button)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Show', () => {
  subject(() => shallow(Show, { store: $store, localVue, router: new VueRouter() }))

  def('getters', () => ({ entry () { return () => $issue } }))
  def('actions', () => ({ initIssue () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('Turbolinks', () => ({ visit: sinon.spy() }))

  beforeEach(() => (global.Turbolinks = $Turbolinks))
  afterEach(() => $subject.vm.$router.push('/'))

  describe('with issue', () => {
    def('issue', () => ({
      id: 1,
      type: 'issues',
      attributes: { title: 'issue title', description: 'description' }
    }))

    it("has currentIssue's title", () => {
      expect($subject.html()).to.include('issue title')
    })

    it('pass description to the markdown_viewer', () => {
      expect($subject.find(MarkdownViewer).props().value).to.eq('description')
    })

    it('call visit on click on the destroy btn', () => {
      $subject.find('.btn.btn-sm.btn-outline-danger').trigger('click')
      expect($Turbolinks.visit).to.have.been.called
    })
  })

  describe('without issue', () => {
    def('issue', () => undefined)

    it('render nothing', () => {
      expect($subject.html()).to.be.undefined
    })
  })
})
