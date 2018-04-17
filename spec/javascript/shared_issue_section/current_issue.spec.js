import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import CurrentIssue from '../../../app/javascript/shared_issue_section/current_issue'
import sinon from 'sinon'
import {
  helperState,
  helperMutations,
  helperGetters,
  helperActions
} from '../../helpers/store'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('CurrentIssue', () => {
  subject(() => shallow(CurrentIssue, { store: $store, localVue }))

  def('store', () => (new Vuex.Store({
    state: { ...helperState, getterData: $getterData },
    mutations: helperMutations,
    getters: helperGetters,
    actions: helperActions
  })))

  def('getterData', () => ({ currentIssue: $currentIssue }))

  def('Turbolinks', () => ({ visit: sinon.spy() }))

  beforeEach(() => { global.Turbolinks = $Turbolinks })

  describe('with currentIssue', () => {
    def('currentIssue', () => ({
      id: 1,
      type: 'issues',
      attributes: { title: 'current issue title' },
      relationships: { 'board-list': { data: { id: 1, type: 'board-lists' } } }
    }))

    it("has currentIssue's title", () => {
      expect($subject.html()).to.include('current issue title')
    })

    it('call visit on click link', () => {
      $subject.find('a').trigger('click')
      expect($Turbolinks.visit).to.have
        .been.calledWith('/administration/board_lists/1/issues/1')
    })
  })
  describe('without currentIssue', () => {
    def('currentIssue', () => undefined)

    it('render nothing', () => {
      expect($subject.html()).to.be.undefined
    })
  })
})
