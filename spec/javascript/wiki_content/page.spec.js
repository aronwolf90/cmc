import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Page from '../../../app/javascript/wiki_content/page'
const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Page', () => {
  subject(() => shallow(Page,
    { store: $store, localVue, propsData: { categoryId: 1 } }
  ))

  def('getters', () => ({ entry () { return () => $page } }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters })))
  def('page', () => ({ id: 1, attributes: { title: 'page title', content: '' } }))

  it('the title is present', () => {
    expect($subject.html()).to.include('page title')
  })

  it('the icon is present', () => {
    expect($subject.html()).to.include('fa-file-text-o')
  })
})
