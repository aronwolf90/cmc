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
      title: 'Test title',
      status: 'none'
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

  it('has .bg-warning when status is warning', () => {
    issue.attributes.status = 'warning'
    const wrapper = factory()

    expect(wrapper.find('.bg-warning').exists()).to.be.true
    expect(wrapper.find('.text-secondary').exists()).to.be.true
  })

  it('has .bg-warning when status is warning', () => {
    issue.attributes.status = 'danger'
    const wrapper = factory()

    expect(wrapper.find('.bg-danger.text-white').exists()).to.be.true
    expect(wrapper.find('.text-secondary').exists()).to.be.false
  })
})
