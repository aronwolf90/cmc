import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import CurrentIssue from '../../../app/javascript/shared_issue_section/current_issue'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('CurrentIssue', () => {
  subject(() => shallow(CurrentIssue, { store: $store, localVue }))

  def('getters', () => ({ currentIssue () { return $currentIssue } }))
  def('actions', () => ({ initCurrentIssue () {} }))
  def('store', () => (new Vuex.Store({ state: {}, getters: $getters, actions: $actions })))
  def('Turbolinks', () => ({ visit: sinon.spy() }))

  beforeEach(() => { global.Turbolinks = $Turbolinks })

  describe('with currentIssue', () => {
    def('currentIssue', () => ({
      id: 1,
      type: 'issues',
      attributes: { title: 'current issue title' }
    }))

    it("has currentIssue's title", () => {
      expect($subject.html()).to.include('current issue title')
    })

    it('call visit on click link', () => {
      $subject.find('a').trigger('click')
      expect($Turbolinks.visit).to.have.been.called
    })
  })
  describe('without currentIssue', () => {
    def('currentIssue', () => undefined)

    it('render nothing', () => {
      expect($subject.html()).to.be.undefined
    })
  })
})
