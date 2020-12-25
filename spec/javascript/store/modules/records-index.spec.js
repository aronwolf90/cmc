import RecordsIndexModule from 'store/modules/records-index.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('store/modules/records-index.js', () => {
  const recordDay = {
    id: '1',
    type: 'record-days',
    attributes: {
      description: 'Test description'
    }
  }

  it('mutations.recordDays', () => {
    const state = { recordDayRefs: null }
    RecordsIndexModule.mutations.recordDays(state, [{ id: '1', type: 'record-days' }])

    expect(state.recordDayRefs).to.eql([{ id: '1', type: 'record-days' }])
  })

  it('getters.recordDays', () => {
    const state = { recordDayRefs: [{ id: '1', type: 'record-days' }] }
    const entry = sandbox.stub()

    entry.withArgs({ id: '1', type: 'record-days' }).returns(recordDay)

    expect(RecordsIndexModule.getters.recordDays(
      state, null, null, { entry }
    )).to.eql([recordDay])
  })

  it('getters.monthSpentTime', () => {
    const context = {
      id: '1',
      type: 'contacts',
      attributes: {
        'month-spent-time': 100
      }
    }

    expect(RecordsIndexModule.getters.monthSpentTime(
      {}, null, null, { context }
    )).to.eql(100)
  })

  it('actions.fetch', async () => {
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()
    const response = {
      data: [recordDay],
      meta: { count: 1 }
    }

    dispatch.withArgs('get', 'record_days?include=records&page=1').returns(Promise.resolve(response))
    await RecordsIndexModule.actions.fetch({ dispatch, commit })

    expect(commit).to.have.been.calledWith('recordDays', [recordDay])
  })
})
