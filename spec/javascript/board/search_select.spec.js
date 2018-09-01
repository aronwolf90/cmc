import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import SearchSelect from '../../../app/javascript/board/search_select'
import { FormInput } from 'bootstrap-vue/es/components'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(FormInput)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('SearchSelect', () => {
  subject(() => mount(SearchSelect, { store: $store, localVue }))

  def('getters', () => ({
    relevantIssues () {
      return (value) => {
        if (value === 'issue1') {
          return [$issue1]
        } else if (value === 'issue2') {
          return [$issue2]
        }
        return []
      }
    },
    entry () {
      return ({ id }) => {
        if (id === 1) {
          return $issue1
        } else if (id === 2) {
          return $issue2
        }
      }
    }
  }))
  def('actions', () => ({ initBoardsLists () {} }))
  def('store', () => (new Vuex.Store({
    state: {},
    getters: $getters,
    actions: $actions
  })))
  def('issue1', () => ({
    id: 1,
    type: 'issues',
    attributes: { title: 'issue1' },
    relationships: {
      'board-list': { data: { id: 1, type: 'board-lits' } }
    }
  }))
  def('issue2', () => ({
    id: 2,
    type: 'issues',
    attributes: { title: 'issue2' },
    relationships: {
      'board-list': { data: { id: 1, type: 'board-lits' } }
    }
  }))
  describe('when write into input issue1', () => {
    it('show issue1', (done) => {
      let input = $subject.find('input')
      input.element.value = 'issue1'
      input.trigger('input')
      input.trigger('focus')
      $subject.vm.$nextTick(() => {
        expect($subject.html()).to.include('issue1')
        done()
      })
    })
  })

  describe('when write into input issue2', () => {
    it('show issue2', (done) => {
      let input = $subject.find('input')
      input.element.value = 'issue2'
      input.trigger('input')
      input.trigger('focus')
      $subject.vm.$nextTick(() => {
        expect($subject.html()).to.include('issue2')
        done()
      })
    })
  })
})
