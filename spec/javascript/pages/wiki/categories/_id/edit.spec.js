import PagesWikiCategoriesIdEdit from 'pages/wiki/categories/_id/edit'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('pages/wiki/categories/_id/edit', () => {
  const wikiCategory = { id: '1', type: 'wiki-categories' }
  const dispatch = sandbox.stub()
  const factory = () => {
    return createWrapper(PagesWikiCategoriesIdEdit, {
      stubs: {
        'wiki-categories-form': true,
        'form-btn-destroy': true
      },
      mocks: {
        $store: {
          dispatch,
          getters: {
            'wikiCategoriesForm/wikiCategory': wikiCategory
          }
        }
      }
    })
  }

  it('renders the form', () => {
    const wrapper = factory()

    expect(wrapper.find('wiki-categories-form-stub').exists()).to.be.true
  })

  it('calls foldersForm/create on submit event', async () => {
    const wrapper = factory()

    dispatch.withArgs('wikiCategoriesForm/update').returns(true)
    wrapper.find('wiki-categories-form-stub').vm.$emit('submit')
    await wrapper.vm.$nextTick()

    expect(dispatch).to.have.been.calledWith('wikiCategoriesForm/update')
    expect(wrapper.vm.$route.path).to.eql('/administration/wiki')
  })
})
