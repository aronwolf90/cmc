import { shallow, createLocalVue } from "@vue/test-utils"
import Vuex from "vuex"
import IssuesRecordSection from "../../../app/javascript/components/issues_record_section"
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

describe("IssuesRecordSection", () => {
  let actions = {}
  let getters = {}
  let state = {}
  let store

  describe("#consumedTime", () => {
    beforeEach(() => {
      getters = {
        get() {
          return () => { return { id: 1, type: "issues" } }
        },
        currentRecord() {
          return () => { return {
            id: 1, type: "records",
            attributes: { "start_time": "02.21.2018 11:00:00" },
            relationships: { issue: { data: { id: 1, type: "issues" } } }
          } }
        }
      }
      store = new Vuex.Store({
        state,
        getters,
        actions
      })
    })

    it("returns the correct time as string", () => {
      this.clock = sinon.useFakeTimers(new Date("02.21.2018 12:30:10"));
      const wrapper = shallow(IssuesRecordSection, { store, localVue })
      expect(wrapper.vm.consumedTime()).to.be.eq("01:30:30")
    })
  })

  describe("clicks", () => {
    let user =  { id: 1, type: "users" }
    let issue = { id: 1, type: "issues" }
    let create_record_spy = sinon.spy()

    beforeEach(() => {
      getters = {
        get() {
          return () => { return issue }
        },
        currentUser() {
          return () => { return user }
        },
        currentRecord() {
          return () => { return null }
        }
      }

      actions = {
        createRecord(context, param) {
          create_record_spy(param)
        }
      }

      store = new Vuex.Store({
        state,
        getters,
        actions
      })
    })

    it("returns the correct time as string", () => {
      const wrapper = shallow(IssuesRecordSection, { store, localVue })
      wrapper.find(".fa-play").trigger("click")
      expect(create_record_spy).to.have.been.calledWith({
        attributes: { "start-time": "Wed Feb 21 2018 12:30:10 GMT+0000 (UTC)" },
        user,
        issue
      });
    })
  })
})
