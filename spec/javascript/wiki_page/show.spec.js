import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Show from '../../../app/javascript/wiki_page/show'
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

  def('getters', () => ({ entry () { return () => $wikiPage } }))
  def('actions', () => ({ initWikiPage () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('Turbolinks', () => ({ visit: sinon.spy() }))

  beforeEach(() => (global.Turbolinks = $Turbolinks))
  afterEach(() => $subject.vm.$router.push('/'))

  describe('with wikiPage', () => {
    def('wikiPage', () => ({
      id: 1,
      type: 'wiki-pages',
      attributes: { title: 'wiki page title', content: 'content' }
    }))

    it("has wiki pages's title", () => {
      expect($subject.html()).to.include('wiki page title')
    })

    it('pass content to the markdown_viewer', () => {
      expect($subject.find(MarkdownViewer).props().value).to.eq('content')
    })

    it('edit btn point to /edit route', () => {
      $subject.find('.fa-edit').trigger('click')
      expect($subject.vm.$router.currentRoute.path).to.eq('/edit')
    })

    it('call visit on click on the destroy btn', () => {
      $subject.find('.btn.btn-sm.btn-outline-danger').trigger('click')
      expect($Turbolinks.visit).to.have.been.called
    })
  })

  describe('without wiki_page', () => {
    def('wikiPage', () => undefined)

    it('render nothing', () => {
      expect($subject.html()).to.be.undefined
    })
  })
})
