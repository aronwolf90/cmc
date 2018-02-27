import { shallow, createLocalVue } from "@vue/test-utils"
import Vuex from "vuex"
import IssuesRecordSection from "../../../app/javascript/components/issues_record_section"
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)

describe("Actions.vue", () => {
  let actions
  let getters
  let store

  beforeEach(() => {
    actions = {
    }
    getters = {
      get() {
        return () => { return { id: 1, type: "records" } }
      },
      getGlobalConfig() {
        return () => { return {} }
      },
      getAssociatedEntry() {
        return () => { return { id: 1, type: "records", attributes: { "start_time": "02.21.2018 11:00:00" } } }
      }
    }
    store = new Vuex.Store({
      state: {},
      getters,
      actions
    })
  })

  it("gvjhkl", (done) => {
    this.clock = sinon.useFakeTimers();
    const wrapper = shallow(IssuesRecordSection, { store, localVue })
    console.log(wrapper.html())
    this.clock.tick(1001);
    this.clock.restore()
    wrapper.vm.$nextTick(() => {
      console.log(wrapper.html())
      done()
    })
    // const button = wrapper.find(".play_btn")
    //button.trigger("click")
  })
})
