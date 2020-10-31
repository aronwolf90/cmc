import createWrapper from '../helper'
import ProjectIndex from 'projects/index'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('ProjectIndex', () => {
  it('renders project index item', () => {
    const entry = sandbox.stub()
    const project = {
      id: 1,
      type: 'projects',
      attributes: { name: 'Test name' }
    }
    entry.withArgs({ id: 1, type: 'projects' }).returns(project)
    const wrapper = createWrapper(ProjectIndex, {
      mocks: {
        $store: {
          getters: {
            'projectsIndex/projects': [project]
          }
        }
      },
      stubs: { 'project-index-item': true }
    })

    expect(wrapper.html()).to.include('project-index-item-stub')
  })
})
