import ProjectSelect from 'components/form-inputs/issue-select'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('components/form-inputs/issue-select.vue', () => {
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
    const propsData = { value: { id: '1', type: 'issues' } }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find('search-select-stub')

    expect(searchSelect.vm.value).to.eql({ id: '1', type: 'issues' })
  })

  it('renders label', () => {
    const propsData = { label: 'Test' }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find('search-select-stub')

    expect(searchSelect.vm.label).to.eql('Test')
  })

  it('renders options', () => {
    const issue = {
      id: 1,
      type: 'issues',
      attributes: { name: 'Test' }
    }
    const collection = sandbox.stub()
    collection.withArgs('issues').returns([issue])
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

    expect(searchSelect.vm.options).to.eql([{ id: 1, type: 'issues' }])
  })

  it('emit input when receive input event', () => {
    const wrapper = factory({})
    const searchSelect = wrapper.find('search-select-stub')

    searchSelect.vm.$emit('input', { id: '1', type: 'issues' })

    expect(wrapper.emitted().input[0][0]).to.eql({ id: '1', type: 'issues' })
  })
})
