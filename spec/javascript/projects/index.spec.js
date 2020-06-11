import createWrapper from '../helper'
import ProjectIndex from '../../../app/javascript/projects/index'
import sinon from 'sinon'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('ProjectIndex', () => {
  it('renders project index item', () => {
    const entry = sinon.stub()
    const project = { id: 1, type: 'projects', attributes: { name: 'Test name' } }
    const wrapper = createWrapper(ProjectIndex, {
      mocks: { $store: { getters: { entry } } },
      stubs: { 'project-index-item': '<project-index-item></project-index-item>' }
    })
    entry.withArgs({ id: 1, type: 'projects' }).returns(project)
    wrapper.setData({ projectRefs: [{ id: 1, type: 'projects' }] })

    expect(wrapper.html()).to.contain('project-index-item')
  })
})
