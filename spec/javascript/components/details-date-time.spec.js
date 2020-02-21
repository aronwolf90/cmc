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

  it('send submit event when submit is called', () => {
    const wrapper = mount(DetailsDateTime, { localVue, attachToDocument: true })
    wrapper.find('[type="submit"]').trigger('click')
    expect(wrapper.emitted().submit).not.to.be.null
  })

  it('show spinner when when isSaving==false', () => {
    const wrapper = mount(DetailsDateTime, {
      localVue,
      attachToDocument: true,
      propsData: {
        isSaving: false
      }
    })
    expect(wrapper.find('.fa-spinner').exists()).to.be.false
  })

  it('show spinner when when isSaving==true', () => {
    const wrapper = mount(DetailsDateTime, {
      localVue,
      attachToDocument: true,
      propsData: {
        isSaving: true
      }
    })
    expect(wrapper.find('.fa-spinner').exists()).to.be.true
  })

  it('show submit button when isPersisted==true', () => {
    const wrapper = mount(DetailsDateTime, {
      localVue,
      attachToDocument: true,
      propsData: {
        isPersisted: true
      }
    })
    expect(wrapper.find('.persisted').exists()).to.be.true
  })

  it('do not show submit button when isPersisted==true', () => {
    const wrapper = mount(DetailsDateTime, {
      localVue,
      attachToDocument: true,
      propsData: {
        isPersisted: false
      }
    })
    expect(wrapper.find('.persisted').exists()).to.be.false
  })
})
