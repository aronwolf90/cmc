import RecordsForm from 'store/modules/records-form.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('store/modules/records-form.js', () => {
  it('mutations.clear', () => {
    const state = {}
    RecordsForm.mutations.clear(state)

    expect(state).to.eql({
      form: {
        attributes: {
          'start-time': null,
          'end-time': null
        },
        relationships: {
          issue: {
            data: null
          }
        }
      }
    })
  })

  it('mutations.formStartTime', () => {
    const state = { form: { attributes: { 'start-time': null } } }
    RecordsForm.mutations.formStartTime(state, '10.10.2020 10:10')

    expect(state.form.attributes['start-time']).to.eql('10.10.2020 10:10')
  })

  it('mutations.formEndTime', () => {
    const state = { form: { attributes: { 'end-time': null } } }
    RecordsForm.mutations.formEndTime(state, '10.10.2020 10:10')

    expect(state.form.attributes['end-time']).to.eql('10.10.2020 10:10')
  })

  it('mutations.formIssueRef', () => {
    const state = { form: { relationships: { issue: { data: null } } } }
    RecordsForm.mutations.formIssueRef(state, { id: '1', type: 'issues' })

    expect(state.form.relationships.issue.data).to.eql({ id: '1', type: 'issues' })
  })

  it('actions.initializeNewForm', async () => {
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()
    await RecordsForm.actions.initializeNewForm({ dispatch, commit })

    expect(commit).to.have.been.calledWith('clear')
    expect(dispatch).to.have.been.calledWith('get', 'issues', { root: true })
  })

  it('getters.formIssueRef', async () => {
    const state = { form: { relationships: { issue: { data: { id: '1', type: 'issues' } } } } }
    expect(RecordsForm.getters.formIssueRef(state)).to.eql({ id: '1', type: 'issues' })
  })

  it('getters.formStartTime', async () => {
    const state = { form: { attributes: { 'start-time': '10.10.2020 10:10' } } }
    expect(RecordsForm.getters.formStartTime(state)).to.eql('10.10.2020 10:10')
  })

  it('getters.formEndTime', async () => {
    const state = { form: { attributes: { 'end-time': '10.10.2020 10:10' } } }
    expect(RecordsForm.getters.formEndTime(state)).to.eql('10.10.2020 10:10')
  })

  it('actions.create returns true when dispatch.create succeed', async () => {
    const dispatch = sandbox.stub()
    const state = { form: { attributes: { 'start-time': '10.10.2020 10:10' } } }

    dispatch.returns(Promise.resolve())
    expect(await RecordsForm.actions.create({ dispatch, state })).to.eq(true)

    expect(dispatch).to.have.been.calledWith('create', {
      resource: 'records',
      payload: state.form
    }, { root: true })
  })
})
