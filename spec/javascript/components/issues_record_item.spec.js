import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import IssuesRecordSection from '../../../app/javascript/components/issues_record_section'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef, no-unused-expressions */

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

    it('create record', (done) => {
      const wrapper = shallow(IssuesRecordSection, { store, localVue })
      wrapper.find('.fa-play').trigger('click')
      wrapper.vm.$nextTick(() => {
        expect(createRecordSpy).to.have.been.called
        done()
      })
    })
  })
})
