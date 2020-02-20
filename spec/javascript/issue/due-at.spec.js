import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import DueAt from '../../../app/javascript/issue/due-at'
import BootstrapVue from 'bootstrap-vue'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(BootstrapVue)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('DueAt', () => {
  it('call updateIssue when submit button is clicked', (done) => {
    const issue = { attributes: { 'due-at': '10-10-2020 00:00' } }
    const store = new Vuex.Store({
      getters: {
        issue () { return issue }
      },
      actions: {
        initIssue () {
          return Promise.resolve({ data: { data: issue } })
        },
        updateIssue (context, { attributes }) {
          expect(attributes['due-at']).to.eq('10-10-2020 00:00')
          done()
        }
      }
    })
    let wrapper = mount(DueAt, { store, localVue, attachToDocument: true })
    wrapper.vm.$nextTick(() => {
      wrapper.find('[type="submit"]').trigger('click')
    })
  })
})
