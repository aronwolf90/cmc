import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Complexity from '../../../app/javascript/issue/complexity'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Complexity', () => {
  subject(() => mount(Complexity, { store: $store, localVue }))

  def('store', () => (new Vuex.Store({
    getters: {
      entry () { return () => $issue }
    },
    actions: $actions
  })))

  def('actions', ({
    updateIssue: sinon.spy()
  }))

  def('issue', () => ({
    id: 1,
    type: 'issues'
  }))

  it('has options', () => {
    expect($subject.html()).to.include('0.5')
  })

  describe('when the issue has a complexity', () => {
    def('issue', () => ({
      id: 1,
      type: 'issues',
      attributes: { complexity: '0.5' }
    }))

    it('current complexity is displayed', () => {
      expect($subject.find('.text').html()).to.include('0.5')
    })
  })

  describe('when the issue has not a complexity', () => {
    def('issue', () => ({
      id: 1,
      type: 'issues'
    }))

    it('no current complexity is displayed', () => {
      expect($subject.find('.text').html()).to.not.include('0.5')
    })
  })

  describe('when an option is selected', () => {
    beforeEach(() => {
      $subject.findAll('.item').at(1).trigger('click')
    })

    it('call updateIssue', () => {
      expect($actions.updateIssue).to.have.been.calledWith(
        sinon.match.any,
        { entry: $issue, attributes: { complexity: '0.5' } }
      )
    })
  })
})
