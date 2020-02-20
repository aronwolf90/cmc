import { mount, createLocalVue } from '@vue/test-utils'
import DetailsDateTime from '../../../app/javascript/components/details-date-time'
import BootstrapVue from 'bootstrap-vue'

const localVue = createLocalVue()
localVue.use(BootstrapVue)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('DetailsDateTime', () => {
  it('form and input is present', () => {
    const wrapper = mount(DetailsDateTime, { localVue, attachToDocument: true })
    expect(wrapper.find('form').exists()).to.be.true
    expect(wrapper.find('input').exists()).to.be.true
  })
})
