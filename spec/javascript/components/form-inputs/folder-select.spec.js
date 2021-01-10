import FoldersSelect from 'components/form-inputs/folder-select'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('components/form-inputs/issue-select.vue', () => {
  const dispatch = sandbox.stub()
  const entry = sandbox.stub()
  const folder = {
    id: 1,
    type: 'folders',
    attributes: { name: 'Folder' }
  }
  const factory = (params = {}) => {
    dispatch.withArgs('get', `/api/v1/folders?query=&filter[project_id]=null`).returns(Promise.resolve({ data: [folder] }))
    entry.withArgs({ id: 1, type: 'folders' }).returns(folder)
    return createWrapper(FoldersSelect, {
      stubs: {
        'search-select': true
      },
      mocks: {
        $store: {
          dispatch,
          getters: {
            entry
          }
        }
      },
      ...params
    })
  }

  it('select value', () => {
    const propsData = { value: { id: '1', type: 'folders' } }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find('search-select-stub')

    expect(searchSelect.vm.value).to.eql({ id: '1', type: 'folders' })
  })

  it('renders label', () => {
    const propsData = { label: 'Folder' }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find('search-select-stub')

    expect(searchSelect.vm.label).to.eql('Folder')
  })

  it('renders options', async () => {
    const wrapper = factory()
    const searchSelect = wrapper.find('search-select-stub')

    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    expect(searchSelect.vm.folderRefs).to.eql([{ id: 1, type: 'folders' }])
    expect(searchSelect.vm.getOptionLabel({ id: 1, type: 'folders' }))
      .to.eq('Folder')
  })

  it('emit input when receive input event', () => {
    const wrapper = factory({})
    const searchSelect = wrapper.find('search-select-stub')

    searchSelect.vm.$emit('input', { id: '1', type: 'folders' })

    expect(wrapper.emitted().input[0][0]).to.eql({ id: '1', type: 'folders' })
  })
})
