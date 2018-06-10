import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Folder from '../../../app/javascript/archive_content/folder'
import Document from '../../../app/javascript/archive_content/document'
const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Folder', () => {
  subject(() => shallow(Folder,
    { store: $store, localVue, propsData: { folderId: 1 } }))

  def('getters', () => ({
    entry () {
      return ({id}) => {
        if (id === 1) return $folder
        return $childFolder
      }
    },
    associatedEntries () {
      return ({entry, name}) => {
        if (entry !== $folder) return []
        if (name === 'folders') return $childFolders
        return $documents
      }
    }
  }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters })))

  def('folder', () => ({ id: 1, attributes: { name: 'folder name' } }))
  def('childFolder', () => ({ id: 2, title: 'child folder name' }))
  def('childFolders', () => [$childFolder])
  def('document', () => ({ id: 1, attributes: { name: 'document name' } }))
  def('documents', () => [$document])

  it('the name is present', () => {
    expect($subject.html()).to.include('folder name')
  })

  it('the folder icon is present', () => {
    expect($subject.html()).to.include('fa-tags')
  })

  it('render the child folder', () => {
    expect($subject.find(Folder).exists()).to.be.true
  })

  it('render the document', () => {
    expect($subject.find(Document).exists()).to.be.true
  })
})
