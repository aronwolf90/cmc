import createWrapper from '../helper'
import ProjectSelect from '../../../app/javascript/components/project-select'
import SearchSelect from '../../../app/javascript/components/form-inputs/search-select'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Comments', () => {
  afterEach(() => {
    sandbox.restore()
  })
  const factory = (params = {}) => {
    return createWrapper(ProjectSelect, params)
  }

  it('select value', () => {
    const propsData = { value: { id: '1', value: 'projects' } }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find(SearchSelect)

    expect(searchSelect.vm.value).to.eql('1')
  })

  it('renders label', () => {
    const propsData = { label: 'Test' }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find(SearchSelect)

    expect(searchSelect.vm.label).to.eql('Test')
  })

  it('renders options', () => {
    const propsData = { options: [{ value: '1', text: 'Test' }] }
    const project = { id: 1, type: 'projects', attributes: { name: 'Test' } }
    const mocks = { $store: { getters: { projects: [project] } } }
    const wrapper = factory({ propsData, mocks })
    const searchSelect = wrapper.find(SearchSelect)

    expect(searchSelect.vm.options).to.eql([{ value: 1, text: 'Test' }])
  })

  it('emit input when receive input event', () => {
    const wrapper = factory({})
    const searchSelect = wrapper.find(SearchSelect)

    searchSelect.vm.$emit('input', '1')

    expect(wrapper.emitted().input[0][0]).to.eql({ id: '1', type: 'projects' })
  })
})
