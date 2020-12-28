import ProjectsRecordsIndexModule from 'store/modules/projects-records-index.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('store/modules/projects-records-index.js', () => {
  const projectRecordDay = {
    id: '1',
    type: 'project-record-days',
    attributes: {
      description: 'Test description'
    }
  }

  it('mutations.projectRecordDays', () => {
    const state = { projectRecordDayRefs: null }
    ProjectsRecordsIndexModule.mutations.projectRecordDays(state,
      [{ id: '1', type: 'project-record-days' }])

    expect(state.projectRecordDayRefs).to.eql([{ id: '1', type: 'project-record-days' }])
  })

  it('getters.projectRecordDays', () => {
    const state = { projectRecordDayRefs: [{ id: '1', type: 'project-record-days' }] }
    const entry = sandbox.stub()

    entry.withArgs({ id: '1', type: 'project-record-days' }).returns(projectRecordDay)

    expect(ProjectsRecordsIndexModule.getters.projectRecordDays(
      state, null, null, { entry }
    )).to.eql([projectRecordDay])
  })

  it('actions.fetch', async () => {
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()
    const response = {
      data: [projectRecordDay],
      meta: { count: 1 }
    }

    dispatch.withArgs('get', 'project_record_days?include=records&page=1&filter[project_id]=1')
      .returns(Promise.resolve(response))
    await ProjectsRecordsIndexModule.actions.fetch({ dispatch, commit }, { projectId: 1 })

    expect(commit).to.have.been.calledWith('projectRecordDays', [projectRecordDay])
  })
})
