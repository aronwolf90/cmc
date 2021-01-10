import PagesArchiveFoldersEdit from 'pages/archive/folders/_id/edit'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('pages/archive/folders/_id/edit', () => {
  const folder = { id: '1', type: 'folders' }
  const dispatch = sandbox.stub()
  const factory = () => {
    return createWrapper(PagesArchiveFoldersEdit, {
      stubs: {
        'archive-folders-form': true,
        'form-btn-destroy': true
      },
      mocks: {
        $store: {
          dispatch,
          getters: {
            'foldersForm/folder': folder
          }
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

    dispatch.withArgs('foldersForm/update').returns(true)
    wrapper.find('archive-folders-form-stub').vm.$emit('submit')
    await wrapper.vm.$nextTick()

    expect(dispatch).to.have.been.calledWith('foldersForm/update')
    expect(wrapper.vm.$route.path).to.eql('/administration/archive')
  })
})
