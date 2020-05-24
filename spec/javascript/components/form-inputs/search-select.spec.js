import createWrapper from '../../helper'
import SearchSelect from '../../../../app/javascript/components/form-inputs/search-select'
import VSelect from 'vue-select'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('DetailsStringInput', () => {
  afterEach(() => {
    sandbox.restore()
  })
  const factory = (propsData) => {
    return createWrapper(SearchSelect, { propsData })
  }

  it('renders options', () => {
    const propsData = {
      options: [{ value: '1', text: 'Test option' }]
    }
    const wrapper = factory(propsData)
    const vSelect = wrapper.find(VSelect)

    expect(vSelect.vm.options).to.eql([{ code: '1', label: 'Test option' }])
  })

  it('select value', (done) => {
    const propsData = {
      value: '1',
      options: [{ value: '1', text: 'Test' }]
    }
    const wrapper = factory(propsData)
    const vSelect = wrapper.find(VSelect)

    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(vSelect.vm.value).to.eql({ code: '1', label: 'Test' })
        done()
      })
    })
  })

  it('renders label', () => {
    const propsData = {
      label: 'Test'
    }
    const wrapper = factory(propsData)

    expect(wrapper.html()).to.include('Test')
  })

  it('renders error', (done) => {
    const propsData = {
      label: 'Project',
      errorPath: '/data/attributes/description',
      errors: [{
        source: {
          pointer: '/data/attributes/description'
        },
        detail: 'Test'
      }]
    }
    const wrapper = factory(propsData)

    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(wrapper.html()).to.include('Test')
          done()
        })
      })
    })
  })
})
