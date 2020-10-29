import ProjectsLeftAsideModule from 'store/modules/projects-left-aside.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('store/modules/projects-left-aside.js', () => {
  it('actions.fetch', async () => {
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()
    const projectStatus = { id: '1', type: 'project-statuses' }
    const response = { data: [projectStatus] }

    dispatch.withArgs('getProjectStatuses').returns(Promise.resolve(response))
    await ProjectsLeftAsideModule.actions.fetch({ dispatch, commit })

    expect(commit).to.have.been.calledWith('projectStatuses', [projectStatus])
  })

  it('mutations.projectStatuses', () => {
    const state = {}
    const projectStatus = { id: '1', type: 'project-statuses' }

    ProjectsLeftAsideModule.mutations.projectStatuses(state, [projectStatus])

    expect(state).to.eql({ projectStatusesRefs: [{ id: '1', type: 'project-statuses' }] })
  })

  it('getters.projectStatuses', () => {
    const state = { projectStatusesRefs: [{ id: '1', type: 'project-statuses' }] }
    const entry = sandbox.stub()
    const projectStatus = { id: '1', type: 'project-statuses' }

    entry.withArgs({ id: '1', type: 'project-statuses' }).returns(projectStatus)

    expect(ProjectsLeftAsideModule.getters.projectStatuses(
      state, null, null, { entry }
    )).to.eql([projectStatus])
  })
})
