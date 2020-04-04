import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Document from '../../../app/javascript/archive_content/document'
const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Document', () => {
  subject(() => shallow(Document,
    { store: $store, localVue, propsData: { documentId: 1 } }))

  def('getters', () => ({
    entry () { return () => { return $document } }
  }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters })))

  def('document', () => ({ id: 1, attributes: { name: 'document name' } }))

  it('the name is present', () => {
    expect($subject.html()).to.include('document name')
  })

  it('the document icon is present', () => {
    expect($subject.html()).to.include('fa-file-text-o')
  })

  it('edit link is presetnt', () => {
    expect($subject.html()).to
      .include('/documents/1/edit')
  })
})
