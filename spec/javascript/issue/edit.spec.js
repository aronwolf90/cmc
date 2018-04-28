import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Edit from '../../../app/javascript/issue/edit'
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

  def('getters', () => ({ entry () { return () => $issue } }))
  def('actions', () => ({ initIssue () { return $sinonPromise }, updateIssue () { return $sinonPromise } }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('Turbolinks', () => ({ visit: sinon.spy() }))
  def('sinonPromise', () => sinon.stub().returnsPromise())

  beforeEach(() => {
    global.Turbolinks = $Turbolinks
    $subject.vm.$router.push('/edit')
  })

  describe('with resolved promise', () => {
    beforeEach(() => {
      $sinonPromise.resolves($issue)
      $subject
    })

    def('issue', () => ({
      id: 1,
      type: 'issues',
      attributes: { title: 'issue title', description: 'description' }
    }))

    it("has currentIssue's title", () => {
      expect($subject.find('.form-control').element.value).to.include('issue title')
    })

    it('pass description to the markdown_viewer', () => {
      expect($subject.find(MarkdownEditor).props().value).to.eq('description')
    })

    it('show btn point to /show route', () => {
      $subject.find('.btn-secondary').trigger('click')
      expect($subject.vm.$router.currentRoute.path).to.eq('/')
    })

    it('setDescription set description value on form', () => {
      $subject.vm.setDescription('test')
      expect($subject.vm.form.attributes.description).to.eq('test')
    })

    describe('submit', () => {
      it('display .fa-spinner', () => {
        $subject.find('button').trigger('submit')
        expect($subject.find('.fa-spinner').exists()).to.be.true
      })
    })
  })
})
