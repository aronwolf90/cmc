import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ArchiveContent from '../../app/javascript/archive_content'
import Folder from '../../app/javascript/archive_content/folder'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('ArchiveContent', () => {
  subject(() => shallow(ArchiveContent, { store: $store, localVue }))
  def('getters', () => ({ metaCollection () { return () => [$folder] } }))

  def('actions', () => ({ initFolders () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('folder', () => ({
    id: 1,
    type: 'folders',
    attributes: { root: true }
  }))

  it('contain the category', () => {
    expect($subject.find(Folder).exists()).to.be.true
  })
})
