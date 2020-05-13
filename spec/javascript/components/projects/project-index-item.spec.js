import createWrapper from '../../helper'
import ProjectIndexItem from '../../../../app/javascript/components/projects/project-index-item'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('ProjectIndexItem', () => {
  const issue = {
    id: 1,
    type: 'projects',
    attributes: {
      name: 'Test title'
    }
  }
  const projectStatus = {
    id: 1,
    type: 'project-statuses',
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
      entry: () => issue,
      relationship: () => projectStatus
    }
  }

  afterEach(() => {
    sandbox.restore()
    dispatch.returns(Promise.resolve())
  })
  const factory = () => {
    return createWrapper(ProjectIndexItem, {
      propsData: { projectId: 1, projectType: 'projects' },
      store
    })
  }

  it('render name', () => {
    const wrapper = factory()

    expect(wrapper.html()).to.include('Test title')
  })

  it('render edit btn', () => {
    const wrapper = factory()

    expect(wrapper.find('.fa.fa-edit').exists()).to.be.true
  })
})
