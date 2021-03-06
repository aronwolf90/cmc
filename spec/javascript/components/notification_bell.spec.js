import NotificationBell from 'components/notification_bell'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('NotificationBell', () => {
  it('show spinner when the promise is not resolved', async () => {
    const dispatch = sandbox.stub()
    dispatch.withArgs('getNotifications').withArgs('getNotifications').returns(Promise.resolve())
    const wrapper = createWrapper(NotificationBell, {
      mocks: {
        $store: {
          dispatch
        }
      },
      attachToDocument: true
    })
    wrapper.find('button').click

    await wrapper.vm.$nextTick()
    expect(wrapper.find('.fa-spinner').exists()).to.be.true
  })

  it('show message when no notifications exist', async () => {
    const dispatch = sandbox.stub()
    dispatch.withArgs('getNotifications').returns(Promise.resolve({
      data: [],
      links: { next: null },
      meta: { 'unread-count': 0 }
    }))
    const wrapper = createWrapper(NotificationBell, {
      mocks: {
        $store: {
          dispatch
        }
      }
    })
    wrapper.find('button').click

    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    expect(wrapper.html()).to.be.include('There are no notifications yet')
  })
})
