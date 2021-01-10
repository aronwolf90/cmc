import FoldersForm from 'store/modules/folders-form.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('store/modules/folders-form.js', () => {
  it('mutations.clear', () => {
    const state = {}
    FoldersForm.mutations.clear(state)

    expect(state).to.eql({
      form: {
        attributes: {
          name: null
        },
        relationships: {
          folder: {
            data: null
          }
        }
      }
    })
  })

  it('mutations.formName', () => {
    const state = { form: { attributes: { name: null } } }
    FoldersForm.mutations.formName(state, 'Test name')

    expect(state.form.attributes.name).to.eql('Test name')
  })

  it('mutations.formFolderRef', () => {
    const state = { form: { relationships: { folder: { data: null } } } }
    FoldersForm.mutations.formFolderRef(state, { id: '1', type: 'folders' })

    expect(state.form.relationships.folder.data).to.eql({ id: '1', type: 'folders' })
  })

  it('mutations.errors', () => {
    const state = { errors: [] }
    FoldersForm.mutations.errors(state, ['error'])

    expect(state.errors).to.eql(['error'])
  })

  it('mutations.folderId', () => {
    const state = { folderId: null }
    FoldersForm.mutations.folderId(state, '1')

    expect(state.folderId).to.eql('1')
  })

  it('mutations.folder', () => {
    const folder = {
      id: '1',
      type: 'folders'
    }
    const state = { folderRef: null }
    FoldersForm.mutations.folder(state, { id: '1', type: 'folders' })

    expect(state.folderRef).to.eql(folder)
  })

  it('getters.formName', () => {
    const state = { form: { attributes: { name: 'Test name' } } }

    expect(FoldersForm.getters.formName(state)).to.eql('Test name')
  })

  it('getters.formFolderRef', () => {
    const state = { form: { relationships: {
      folder: { data: { id: '1', type: 'folders' } } } } }

    expect(FoldersForm.getters.formFolderRef(state))
      .to.eql({ id: '1', type: 'folders' })
  })

  it('getters.folderId', () => {
    const state = { folderId: '1' }

    expect(FoldersForm.getters.folderId(state))
      .to.eql('1')
  })

  it('getters.folder', () => {
    const folder = {
      id: '1',
      type: 'folders'
    }
    const entry = sandbox.stub()
    entry.withArgs({ id: '1', type: 'folders' }).returns(folder)

    expect(FoldersForm.getters.folder(
      { folderRef: { id: '1', type: 'folders' } },
      null,
      null,
      { entry }
    )).to.eql(folder)
  })

  it('actions.initializeNewForm', async () => {
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()
    await FoldersForm.actions.initializeNewForm({ dispatch, commit })

    expect(commit).to.have.been.calledWith('clear')
    expect(dispatch).to.have.been.calledWith('get', 'folders', { root: true })
  })

  it('actions.initializeEditForm', async () => {
    const folder = {
      id: '1',
      type: 'folders',
      attributes: {
        name: 'Test name'
      },
      relationships: {
        folder: {
          data: {
            id: '2',
            type: 'folders'
          }
        }
      }
    }
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()

    dispatch.withArgs('get', 'folders/1', { root: true })
      .returns(Promise.resolve({ data: folder }))

    await FoldersForm.actions.initializeEditForm({ dispatch, commit }, '1')

    expect(commit).to.have.been.calledWith('clear')
    expect(commit).to.have.been.calledWith('folder', folder)
    expect(commit).to.have.been.calledWith('formName', 'Test name')
    expect(commit).to.have.been
      .calledWith('formFolderRef', { id: '2', type: 'folders' })
  })

  it('actions.create returns true when dispatch.create succeed', async () => {
    const dispatch = sandbox.stub()
    const state = { form: { attributes: { name: 'Test name' } } }

    dispatch.returns(Promise.resolve())
    expect(await FoldersForm.actions.create({ dispatch, state })).to.eq(true)

    expect(dispatch).to.have.been.calledWith('create', {
      resource: 'folders',
      payload: state.form
    }, { root: true })
  })

  it('actions.create returns false when dispatch.create fails', async () => {
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()
    const state = { form: { attributes: { name: 'Test name' } } }

    // eslint-disable-next-line prefer-promise-reject-errors
    dispatch.returns(Promise.reject({ data: { errors: ['error'] } }))
    expect(await FoldersForm.actions.create({ dispatch, state, commit })).to.eq(false)

    expect(commit).to.have.been.calledWith('errors', ['error'])
    expect(dispatch).to.have.been.calledWith('create', {
      resource: 'folders',
      payload: state.form
    }, { root: true })
  })

  it('actions.update returns true when dispatch.create succeed', async () => {
    const folder = {
      id: '1',
      type: 'folders'
    }
    const dispatch = sandbox.stub()
    const state = { form: { attributes: { name: 'Test name' } } }
    const getters = { folderId: 1, folder }

    dispatch.returns(Promise.resolve())

    expect(await FoldersForm.actions.update({ dispatch, state, getters }))
      .to.eq(true)

    expect(dispatch).to.have.been.calledWith('update', {
      entry: folder,
      payload: state.form
    }, { root: true })
  })
})
