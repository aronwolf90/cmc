import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import WikiContent from '../../app/javascript/wiki_content'
import Category from '../../app/javascript/wiki_content/category'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('WikiContent', () => {
  subject(() => shallow(WikiContent, { store: $store, localVue }))
  def('getters', () => ({ rootWikiCategories () { return [$category] } }))

  def('actions', () => ({ initWikiCategories () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('category', () => ({
    id: 1,
    type: 'wiki-category',
    attributes: { root: true }
  }))

  it('contain the category', () => {
    expect($subject.find(Category).exists()).to.be.true
  })
})
