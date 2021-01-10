import PagesArchiveFoldersNew from 'pages/archive/folders/new'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('pages/archive/folders/new', () => {
  const dispatch = sandbox.stub()
  const factory = () => {
    return createWrapper(PagesArchiveFoldersNew, {
      stubs: {
        'archive-folders-form': true
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

    expect(wrapper.find('archive-folders-form-stub').exists()).to.be.true
  })

  it('calls foldersForm/create on submit event', async () => {
    const wrapper = factory()

    dispatch.withArgs('foldersForm/create').returns(true)
    wrapper.find('archive-folders-form-stub').vm.$emit('submit')
    await wrapper.vm.$nextTick()

    expect(dispatch).to.have.been.calledWith('foldersForm/create')
    expect(wrapper.vm.$route.path).to.eql('/administration/archive')
  })
})
