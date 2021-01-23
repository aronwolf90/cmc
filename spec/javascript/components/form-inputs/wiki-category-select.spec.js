import WikiCategorySelect from 'components/form-inputs/wiki-category-select'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('components/form-inputs/wiki-category-select.vue', () => {
  const dispatch = sandbox.stub()
  const entry = sandbox.stub()
  const wikiCategory = {
    id: 1,
    type: 'wiki-categories',
    attributes: { title: 'Title' }
  }
  const factory = (params = {}) => {
    dispatch.withArgs('get', `/api/v1/wiki_categories?query=`)
      .returns(Promise.resolve({ data: [wikiCategory] }))
    entry.withArgs({ id: 1, type: 'wiki-categories' })
      .returns(wikiCategory)
    return createWrapper(WikiCategorySelect, {
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
    const propsData = { value: { id: '1', type: 'wiki-categories' } }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find('search-select-stub')

    expect(searchSelect.vm.value).to
      .eql({ id: '1', type: 'wiki-categories' })
  })

  it('renders label', () => {
    const propsData = { label: 'Category' }
    const wrapper = factory({ propsData })
    const searchSelect = wrapper.find('search-select-stub')

    expect(searchSelect.vm.label).to.eql('Category')
  })

  it('renders options', async () => {
    const wrapper = factory()
    const searchSelect = wrapper.find('search-select-stub')

    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    expect(searchSelect.vm.wikiCategoryRefs).to
      .eql([{ id: 1, type: 'wiki-categories' }])
    expect(
      searchSelect.vm.getOptionLabel({ id: 1, type: 'wiki-categories' })
    ).to.eq('Title')
  })

  it('emit input when receive input event', () => {
    const wrapper = factory({})
    const searchSelect = wrapper.find('search-select-stub')

    searchSelect.vm.$emit('input', { id: '1', type: 'wiki-categories' })

    expect(wrapper.emitted().input[0][0]).to
      .eql({ id: '1', type: 'wiki-categories' })
  })
})
