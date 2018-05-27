import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Edit from '../../../app/javascript/wiki_page/edit'
import MarkdownEditor from '../../../app/javascript/markdown_editor'
import sinon from 'sinon'
import VueRouter from 'vue-router'
import sinonStubPromise from 'sinon-stub-promise'
import FormInput from 'bootstrap-vue/es/components/form-input/form-input'
import Form from 'bootstrap-vue/es/components/form/form'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(VueRouter)
localVue.component('b-form-input', FormInput)
localVue.component('b-form', Form)

sinonStubPromise(sinon)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Edit', () => {
  subject(() => mount(Edit, { store: $store, localVue, router: new VueRouter(), stubs: { 'markdown-editor': '<div/>' } }))

  def('getters', () => ({ entry () { return () => $wikiPage } }))
  def('actions', () => ({
    initWikiPage () { return $sinonPromise },
    updateWikiPage () { return $sinonPromise },
    destroy (params) { return $destroySpy('destroy', params) }
  }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('Turbolinks', () => ({ visit: sinon.spy() }))
  def('sinonPromise', () => sinon.stub().returnsPromise())
  def('destroySpy', () => sinon.spy())

  beforeEach(() => {
    global.Turbolinks = $Turbolinks
    $subject.vm.$router.push('/edit')
  })

  describe('with resolved promise', () => {
    beforeEach(() => {
      $sinonPromise.resolves($wikiPage)
      $subject
    })

    def('wikiPage', () => ({
      id: 1,
      type: 'wiki-pages',
      attributes: { title: 'wiki page title', content: 'content' }
    }))

    it('has wiki page title', () => {
      expect($subject.find('.form-control').element.value).to
        .include('wiki page title')
    })

    it('pass content to the markdown_viewer', () => {
      expect($subject.find(MarkdownEditor).props().value).to.eq('content')
    })

    it('show btn point to /show route', () => {
      $subject.find('.btn-secondary').trigger('click')
      expect($subject.vm.$router.currentRoute.path).to.eq('/')
    })

    it('setContent set content value on form', () => {
      $subject.vm.setContent('test')
      expect($subject.vm.form.attributes.content).to.eq('test')
    })

    it('call visit on click on the destroy btn', () => {
      $subject.find('.btn-danger').trigger('click')
      expect($Turbolinks.visit).to
        .have.been.calledWith('/administration/wiki_content')
    })

    it('call destroy action', () => {
      $subject.find('.btn-danger').trigger('click')
      expect($destroySpy).to.have.been.called
    })

    describe('submit', () => {
      it('display .fa-spinner', () => {
        $subject.find('button').trigger('submit')
        expect($subject.find('.fa-spinner').exists()).to.be.true
      })
    })
  })
})
