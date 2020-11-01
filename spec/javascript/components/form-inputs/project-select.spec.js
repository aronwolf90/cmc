import createWrapper from '../../helper'
import ProjectSelect from 'components/form-inputs/project-select'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('components/form-inputs/project-select.vue', () => {
  afterEach(() => {
    sandbox.restore()
  })
  const factory = (params = {}) => {
    return createWrapper(ProjectSelect, {
      stubs: {
        'search-select': true
      },
      mocks: {
        $store: {
          getters: {
            collection () { return undefined }
          }
        }
      },
      ...params
    })
  }

  it('select value', () => {
    const propsData = { value: { id: '1', type: 'projects' } }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find('search-select-stub')

    expect(searchSelect.vm.value).to.eql({ id: '1', type: 'projects' })
  })

  it('renders label', () => {
    const propsData = { label: 'Test' }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find('search-select-stub')

    expect(searchSelect.vm.label).to.eql('Test')
  })

  it('renders options', () => {
    const project = {
      id: 1,
      type: 'projects',
      attributes: { name: 'Test' }
    }
    const collection = sandbox.stub()
    collection.withArgs('projects').returns([project])
    const wrapper = factory({
      mocks: {
        $store: {
          getters: {
            collection
          }
        }
      }
    })
    const searchSelect = wrapper.find('search-select-stub')

    expect(searchSelect.vm.options).to.eql([{ id: 1, type: 'projects' }])
  })

  it('emit input when receive input event', () => {
    const wrapper = factory({})
    const searchSelect = wrapper.find('search-select-stub')

    searchSelect.vm.$emit('input', { id: '1', type: 'projects' })

    expect(wrapper.emitted().input[0][0]).to.eql({ id: '1', type: 'projects' })
  })
})
