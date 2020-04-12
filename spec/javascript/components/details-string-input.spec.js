import { mount, createLocalVue } from '@vue/test-utils'
import DetailsStringInput from '../../../app/javascript/components/details-string-input'
import BootstrapVue from 'bootstrap-vue'

const localVue = createLocalVue()
localVue.use(BootstrapVue)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('DetailsStringInput', () => {
  it('show value on non edit mode', () => {
    const wrapper = mount(DetailsStringInput, {
      localVue,
      attachToDocument: true,
      propsData: {
        value: 'test text',
        editMode: false
      }
    })
    expect(wrapper.html()).to.include('test text')
  })

  it('show value on edit mode', (done) => {
    const wrapper = mount(DetailsStringInput, {
      localVue,
      attachToDocument: true,
      propsData: {
        value: 'test text',
        editMode: true
      }
    })
    wrapper.vm.$nextTick(() => {
      expect(wrapper.find('input').element.value)
        .to.include('test text')
      done()
    })
  })

  it('show value on edit mode', (done) => {
    const wrapper = mount(DetailsStringInput, {
      localVue,
      attachToDocument: true,
      propsData: {
        editMode: true,
        value: 'test text'
      }
    })
    wrapper.vm.$nextTick(() => {
      expect(wrapper.find('input').element.value)
        .to.include('test text')
      done()
    })
  })

  it('changes to edit mode when edit btn is clicked', (done) => {
    const wrapper = mount(DetailsStringInput, {
      localVue,
      attachToDocument: true,
      propsData: {
        editMode: false,
        value: 'test text'
      }
    })
    wrapper.find('.fa-edit').trigger('click')
    wrapper.vm.$nextTick(() => {
      expect(wrapper.find('input').exists()).to.be.true
      done()
    })
  })

  it('emit value when input change', (done) => {
    const wrapper = mount(DetailsStringInput, {
      localVue,
      attachToDocument: true,
      propsData: {
        editMode: true,
        value: ''
      }
    })
    wrapper.find('input').element.value = 'test value'
    wrapper.find('input').trigger('input')
    wrapper.vm.$nextTick(() => {
      expect(wrapper.emitted().input[0][0])
        .to.eq('test value')
      done()
    })
  })

  it('spinner works correctly', (done) => {
    const wrapper = mount(DetailsStringInput, {
      localVue,
      attachToDocument: true,
      propsData: {
        editMode: true
      }
    })
    wrapper.find('button').trigger('click')
    wrapper.vm.$nextTick(() => {
      expect(wrapper.html()).to.include('fa-spinner')
      wrapper.setProps({ editMode: false })
      wrapper.vm.$nextTick(() => {
        expect(wrapper.find('input').exists()).to.be.false
        wrapper.setProps({ editMode: true })
        wrapper.vm.$nextTick(() => {
          expect(wrapper.find('input').exists()).to.be.true
          expect(wrapper.html()).not.to.include('fa-spinner')
          done()
        })
      })
    })
  })
})
