import FoldersForm from 'components/folders/form'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('components/folders/form.vue', () => {
  const folder = {
    id: '1',
    type: 'folders'
  }
  const commit = sandbox.stub()
  const factory = () => {
    return createWrapper(FoldersForm, {
      stubs: {
        'form-inputs-folder-select': true,
        'form-inputs-text': true
      },
      mocks: {
        $store: {
          getters: {
            'folders': [folder],
            'foldersForm/formFolderRef': { id: '1', type: 'folders' },
            'foldersForm/formName': 'Test name',
            'foldersForm/errors': []
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

    expect(wrapper.find('#name-input').props()).to.eql({
      id: 'name-input',
      errorPath: 'attributes/name',
      errors: [],
      label: 'Name',
      value: 'Test name',
      placeholder: undefined
    })
    expect(wrapper.find('#folder-input').props()).to.eql({
      id: 'folder-input',
      errorPath: 'relationships/folder',
      errors: [],
      label: 'Folder',
      value: { id: '1', type: 'folders' }
    })
    expect(wrapper.html()).to.include('Slot content')

    wrapper.find('#name-input').vm.$emit('input', 'New test name')
    wrapper.find('#folder-input').vm.$emit('input', { id: '1', type: 'folders' })

    expect(commit).to.have.been.calledWith('foldersForm/formName', 'New test name')
    expect(commit).to.have.been.calledWith('foldersForm/formFolderRef', { id: '1', type: 'folders' })
  })
})
