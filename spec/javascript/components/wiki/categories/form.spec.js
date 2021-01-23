import WikiCategoriesForm from 'components/wiki/categories/form'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('components/wiki/categories/form.vue', () => {
  const wikiCategory = {
    id: '1',
    type: 'wiki-categories',
    relationships: {
      'wiki-category': {
        data: {
          id: '1',
          type: 'wiki-categories'
        }
      }
    }
  }
  const commit = sandbox.stub()
  const factory = () => {
    return createWrapper(WikiCategoriesForm, {
      stubs: {
        'form-inputs-text': true,
        'form-inputs-wiki-category-select': true
      },
      mocks: {
        $store: {
          getters: {
            'folders': [wikiCategory],
            'wikiCategoriesForm/formWikiCategoryRef': {
              id: '1',
              type: 'wiki-categories'
            },
            'wikiCategoriesForm/formTitle': 'Test title',
            'wikiCategoriesForm/errors': []
          },
          commit
        }
      },
      slots: {
        default: 'Slot content'
      }
    })
  }

  it('is correctly rendered and syncronize changes back to store', () => {
    const wrapper = factory()

    expect(wrapper.find('#title-input').props()).to.eql({
      id: 'title-input',
      errorPath: 'attributes/title',
      errors: [],
      label: 'Title',
      value: 'Test title',
      placeholder: undefined
    })
    expect(wrapper.find('#wiki-category-input').props()).to.eql({
      id: 'wiki-category-input',
      errorPath: 'relationships/wiki-category',
      errors: [],
      label: 'Category',
      value: { id: '1', type: 'wiki-categories' }
    })
    expect(wrapper.html()).to.include('Slot content')

    wrapper.find('#title-input').vm.$emit('input', 'New test name')
    wrapper.find('#wiki-category-input').vm.$emit('input',
      { id: '1', type: 'wiki-categories' })

    expect(commit).to.have.been.calledWith('wikiCategoriesForm/formTitle',
      'New test name')
    expect(commit).to.have.been.calledWith('wikiCategoriesForm/formWikiCategoryRef',
      { id: '1', type: 'wiki-categories' })
  })
})
