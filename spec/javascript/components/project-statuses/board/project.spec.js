import createWrapper from '../../../helper'
import Project from '../../../../../app/javascript/components/project-statuses/board/project'
import sinon from 'sinon'

/* eslint-disable no-undef, no-unused-expressions */

describe('project-statuses/board/project', () => {
  const user = {
    attributes: {
      firstname: 'Firstname',
      lastname: 'Lastname'
    }
  }
  const project = {
    id: '1',
    type: 'projects',
    attributes: {
      name: 'Name'
    },
    relationships: {
      'main-responsable': {
        id: 1,
        type: 'users'
      }
    }
  }

  it('render project name', (done) => {
    const stubedRelationship = sinon.stub()
    const stubedProject = sinon.stub()
    stubedProject.withArgs('1').returns(project)
    stubedRelationship.withArgs({ id: 1, type: 'users' }).returns(user)
    const wrapper = createWrapper(Project, {
      propsData: {
        projectId: '1'
      },
      mocks: {
        $store: {
          getters: {
            project: stubedProject,
            relationship: stubedRelationship
          }
        }
      }
    })

    wrapper.vm.$nextTick(() => {
      expect(wrapper.html()).to.include('Name')
      done()
    })
  })
})
