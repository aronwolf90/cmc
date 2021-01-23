import PagesWikiCategoriesNew from 'pages/wiki/categories/new'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('pages/wiki/categories/new', () => {
  const dispatch = sandbox.stub()
  const factory = () => {
    return createWrapper(PagesWikiCategoriesNew, {
      stubs: {
        'wiki-categories-form': true
      },
      mocks: {
        $store: {
          dispatch
        }
      }
    })
  }

  it('renders the form', () => {
    const wrapper = factory()

    expect(wrapper.find('wiki-categories-form-stub').exists()).to.be.true
  })

  it('calls wikiCategoriesForm/create on submit event', async () => {
    const wrapper = factory()

    dispatch.withArgs('wikiCategoriesForm/create').returns(true)
    wrapper.find('wiki-categories-form-stub').vm.$emit('submit')
    await wrapper.vm.$nextTick()

    expect(dispatch).to.have.been.calledWith('wikiCategoriesForm/create')
    expect(wrapper.vm.$route.path).to.eql('/administration/wiki')
  })
})
