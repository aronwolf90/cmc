import createWrapper from '../../helper'
import Reminder from '../../../../app/javascript/components/projects/reminder'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('Reminder', () => {
  const issue = {
    id: 1,
    type: 'issues',
    attributes: {
      title: 'Test title'
    }
  }
  const dispatch = sandbox.stub()
  const commit = sandbox.stub()
  const store = {
    dispatch,
    commit,
    getters: {
      entry: () => issue
    }
  }

  afterEach(() => {
    sandbox.restore()
    dispatch.returns(Promise.resolve())
  })
  const factory = () => {
    return createWrapper(Reminder, {
      store,
      stubs: { Reminder }
    })
  }

  it('render reminders', () => {
    const wrapper = factory()

    expect(wrapper.html()).to.include('Test title')
  })

  it('trigger closeIssue when check is clicked', () => {
    const wrapper = factory()
    wrapper.find('.fa-check').trigger('click')

    expect(dispatch).to.have.been.calledWith('projectsShow/closeIssue')
  })
})
