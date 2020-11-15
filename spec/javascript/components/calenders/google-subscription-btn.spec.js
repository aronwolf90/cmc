import CalendarsGoogleSubscriptionBtn from 'components/calendars/google-subscription-btn'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('CalendarsGoogleSubscriptionBtn', () => {
  it('show  "Integrate with google calendar" when isGoogleIntegrated is false', () => {
    const wrapper = createWrapper(CalendarsGoogleSubscriptionBtn, {
      propsData: {
        isGoogleIntegrated: false
      }
    })

    expect(wrapper.html()).to.include('Integrate with google')
  })

  it('show  "Cancel google calendar integration" when isGoogleIntegrated< is true', () => {
    const wrapper = createWrapper(CalendarsGoogleSubscriptionBtn, {
      propsData: {
        isGoogleIntegrated: true
      }
    })

    expect(wrapper.html()).to.include('Destroy google integration')
  })
})
