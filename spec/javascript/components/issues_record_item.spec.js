import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import IssuesRecordSection from '../../../app/javascript/components/issues_record_section'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */

describe('IssuesRecordSection', () => {
  let actions = {}
  let getters = {}
  let state = {}
  let store

  describe('clicks', () => {
    let user = { id: 1, type: 'users' }
    let issue = { id: 1, type: 'issues' }
    let createRecordSpy = sinon.spy()

    beforeEach(() => {
      getters = {
        entry () {
          return () => { return issue }
        },
        currentUser () {
          return user
        },
        currentRecord () {
          return undefined
        }
      }

      actions = {
        createRecord (context, param) {
          createRecordSpy(param)
        }
      }

      store = new Vuex.Store({
        state,
        getters,
        actions
      })
    })
    beforeEach(() => (this.clock = sinon.useFakeTimers(new Date('Wed Feb 21 2018 12:30:10 GMT+0000 (UTC)'))))
    afterEach(() => (this.clock = this.clock.restore()))

    it('create record', () => {
      const wrapper = shallow(IssuesRecordSection, { store, localVue })
      wrapper.find('.fa-play').trigger('click')
      expect(createRecordSpy).to.have.been.calledWith({
        attributes: { 'start-time': 'Wed Feb 21 2018 12:30:10 GMT+0000 (UTC)' },
        user,
        issue
      })
    })
  })
})
