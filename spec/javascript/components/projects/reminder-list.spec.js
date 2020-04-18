import createWrapper from '../../helper'
import ReminderList from '../../../../app/javascript/components/projects/reminder-list'
import Reminder from '../../../../app/javascript/components/projects/reminder'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('ReminderList', () => {
  const issue = { id: 1, type: 'issues' }
  const dispatch = sandbox.stub()
  const commit = sandbox.stub()
  const store = {
    dispatch,
    commit,
    getters: {
      'projectsShow/reminders': [issue]
    }
  }

  afterEach(() => {
    sandbox.restore()
    dispatch.returns(Promise.resolve())
  })
  const factory = () => {
    return createWrapper(ReminderList, {
      store,
      stubs: { reminder: true }
    })
  }

  it('render reminders', () => {
    const wrapper = factory()

    expect(wrapper.find(Reminder).exists())
  })
})
