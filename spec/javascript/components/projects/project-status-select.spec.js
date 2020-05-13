import createWrapper from '../../helper'
import ProjectStatusSelect from '../../../../app/javascript/components/projects/project-status-select'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('ProjectStatusSelect', () => {
  const projectStatus = {
    id: 1,
    type: 'project-statuses',
    attributes: {
      name: 'Test title'
    }
  }
  const project = {
    id: 1,
    type: 'projecs',
    attributes: {
      name: 'Test title'
    }
  }
  const dispatch = sandbox.stub()
  const commit = sandbox.stub()
  const store = {
    dispatch,
    commit,
    getters: {
      projectStatuses: [projectStatus],
      projectStatus: projectStatus,
      project: project
    }
  }

  afterEach(() => {
    sandbox.restore()
    dispatch.returns(Promise.resolve())
  })

  const factory = () => {
    return createWrapper(ProjectStatusSelect, { store })
  }

  it('render blank option', () => {
    const wrapper = factory()

    expect(wrapper.findAll('.item').at(0).element.textContent).to.eq('\n        \n      ')
  })

  it('render options', () => {
    const wrapper = factory()

    expect(wrapper.html()).to.include('Test title')
  })

  it('render project status', () => {
    const wrapper = factory()

    expect(wrapper.findAll('.item').at(1).element.textContent)
      .to.eql('\n        Test title\n      ')
  })
})
