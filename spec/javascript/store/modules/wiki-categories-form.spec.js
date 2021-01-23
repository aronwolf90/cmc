import WikiCategoriesForm from 'store/modules/wiki-categories-form.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('store/modules/wiki-categories-form.js', () => {
  it('mutations.clear', () => {
    const state = {}
    WikiCategoriesForm.mutations.clear(state)

    expect(state).to.eql({
      form: {
        attributes: {
          title: null
        },
        relationships: {
          'wiki-category': {
            data: null
          }
        }
      },
      errors: []
    })
  })

  it('mutations.formtitle', () => {
    const state = { form: { attributes: { title: null } } }
    WikiCategoriesForm.mutations.formTitle(state, 'Test title')

    expect(state.form.attributes.title).to.eql('Test title')
  })

  it('mutations.formWikiCategoryRef', () => {
    const state = {
      form: {
        relationships: { 'wiki-category': { data: null } }
      }
    }
    WikiCategoriesForm.mutations.formWikiCategoryRef(state,
      { id: '1', type: 'wiki-categories' })

    expect(state.form.relationships['wiki-category'].data).to
      .eql({ id: '1', type: 'wiki-categories' })
  })

  it('mutations.errors', () => {
    const state = { errors: [] }
    WikiCategoriesForm.mutations.errors(state, ['error'])

    expect(state.errors).to.eql(['error'])
  })

  it('mutations.wikiCategoryId', () => {
    const state = { folderId: null }
    WikiCategoriesForm.mutations.wikiCategoryId(state, '1')

    expect(state.wikiCategoryId).to.eql('1')
  })

  it('mutations.wikiCategory', () => {
    const wikiCategory = {
      id: '1',
      type: 'wiki-categories'
    }
    const state = { wikiCategoryRef: null }
    WikiCategoriesForm.mutations.wikiCategory(state,
      { id: '1', type: 'wiki-categories' })

    expect(state.wikiCategoryRef).to.eql(wikiCategory)
  })

  it('getters.formTitle', () => {
    const state = { form: { attributes: { title: 'Test title' } } }

    expect(WikiCategoriesForm.getters.formTitle(state)).to.eql('Test title')
  })

  it('getters.formwikiCategoryRef', () => {
    const state = { form: { relationships: {
      'wiki-category': { data: { id: '1', type: 'wiki-categories' } } } } }

    expect(WikiCategoriesForm.getters.formWikiCategoryRef(state))
      .to.eql({ id: '1', type: 'wiki-categories' })
  })

  it('getters.wikiCategoryId', () => {
    const state = { wikiCategoryId: '1' }

    expect(WikiCategoriesForm.getters.wikiCategoryId(state))
      .to.eql('1')
  })

  it('getters.wikiCategory', () => {
    const wikiCategory = {
      id: '1',
      type: 'wiki-categories'
    }
    const entry = sandbox.stub()
    entry.withArgs({ id: '1', type: 'wiki-categories' })
      .returns(wikiCategory)

    expect(WikiCategoriesForm.getters.wikiCategory(
      { wikiCategoryRef: { id: '1', type: 'wiki-categories' } },
      null,
      null,
      { entry }
    )).to.eql(wikiCategory)
  })

  it('actions.initializeNewForm', async () => {
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()
    await WikiCategoriesForm.actions.initializeNewForm({ dispatch, commit })

    expect(commit).to.have.been.calledWith('clear')
    expect(dispatch).to.have.been.calledWith('get', 'wiki_categories',
      { root: true })
  })

  it('actions.initializeEditForm', async () => {
    const wikiCategory = {
      id: '1',
      type: 'wiki-categories',
      attributes: {
        title: 'Test title'
      },
      relationships: {
        'wiki-category': {
          data: {
            id: '2',
            type: 'wiki-categories'
          }
        }
      }
    }
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()

    dispatch.withArgs('get', 'wiki_categories/1', { root: true })
      .returns(Promise.resolve({ data: wikiCategory }))

    await WikiCategoriesForm.actions.initializeEditForm({ dispatch, commit }, '1')

    expect(commit).to.have.been.calledWith('clear')
    expect(commit).to.have.been.calledWith('wikiCategory', wikiCategory)
    expect(commit).to.have.been.calledWith('formTitle', 'Test title')
    expect(commit).to.have.been.calledWith('formWikiCategoryRef',
      { id: '2', type: 'wiki-categories' })
  })

  it('actions.create returns true when dispatch.create succeed', async () => {
    const dispatch = sandbox.stub()
    const state = { form: { attributes: { name: 'Test title' } } }

    dispatch.returns(Promise.resolve())
    expect(await WikiCategoriesForm.actions.create({ dispatch, state }))
      .to.eq(true)

    expect(dispatch).to.have.been.calledWith('create', {
      resource: 'wiki_categories',
      payload: state.form
    }, { root: true })
  })

  it('actions.create returns false when dispatch.create fails', async () => {
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()
    const state = { form: { attributes: { name: 'Test name' } } }

    // eslint-disable-next-line prefer-promise-reject-errors
    dispatch.returns(Promise.reject({ data: { errors: ['error'] } }))
    expect(await WikiCategoriesForm.actions.create({ dispatch, state, commit }))
      .to.eq(false)

    expect(commit).to.have.been.calledWith('errors', ['error'])
    expect(dispatch).to.have.been.calledWith('create', {
      resource: 'wiki_categories',
      payload: state.form
    }, { root: true })
  })

  it('actions.update returns true when dispatch.create succeed', async () => {
    const wikiCategory = {
      id: '1',
      type: 'wiki-categories'
    }
    const dispatch = sandbox.stub()
    const state = { form: { attributes: { name: 'Test name' } } }
    const getters = { wikiCategoryId: 1, wikiCategory }

    dispatch.returns(Promise.resolve())

    expect(await WikiCategoriesForm.actions
      .update({ dispatch, state, getters })).to.eq(true)

    expect(dispatch).to.have.been.calledWith('update', {
      entry: wikiCategory,
      payload: state.form
    }, { root: true })
  })
})
