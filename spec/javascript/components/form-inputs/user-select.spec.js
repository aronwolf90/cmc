import createWrapper from '../../helper'
import ProjectSelect from 'components/form-inputs/user-select'
import SearchSelect from 'components/form-inputs/search-select'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Comments', () => {
  afterEach(() => {
    sandbox.restore()
  })
  const factory = (params = {}) => {
    return createWrapper(ProjectSelect, {
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
    const propsData = { value: { id: '1', value: 'users' } }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find(SearchSelect)

    expect(searchSelect.vm.value).to.eql({ id: '1', value: 'users' })
  })

  it('pass label to searchSelect', () => {
    const propsData = { label: 'Test' }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find(SearchSelect)

    expect(searchSelect.vm.label).to.eql('Test')
  })

  it('renders options', () => {
    const user = {
      id: 1,
      type: 'users',
      attributes: {
        firstname: 'Lara',
        lastname: 'Cruise'
      }
    }
    const collection = sandbox.stub()
    collection.withArgs('users').returns([user])

    const wrapper = factory({
      mocks: {
        $store: {
          getters: {
            collection
          }
        }
      }
    })
    const searchSelect = wrapper.find(SearchSelect)

    expect(searchSelect.vm.options).to.eql([{ id: 1, type: 'users' }])
  })

  it('emit input when receive input event', () => {
    const wrapper = factory({})
    const searchSelect = wrapper.find(SearchSelect)

    searchSelect.vm.$emit('input', { id: 1, type: 'users' })

    expect(wrapper.emitted().input[0][0])
      .to.eql({ id: 1, type: 'users' })
  })
})
