import CalendarsGoogleSubscriptionBtn from 'components/calendars/google-subscription-btn'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('CalendarsGoogleSubscriptionBtn', () => {
  it('show "Integrate with google calendar" when isGoogleIntegrated is false', () => {
    const wrapper = createWrapper(CalendarsGoogleSubscriptionBtn, {
      propsData: {
        isGoogleIntegrated: false,
        authorizationUrl: 'href://www.example.com'
      }
    })

    expect(wrapper.html()).to.include('Integrate with google')
    expect(wrapper.html()).to.include('href://www.example.com')
  })

  it('show "Cancel google calendar integration" when isGoogleIntegrated< is true', () => {
    const wrapper = createWrapper(CalendarsGoogleSubscriptionBtn, {
      propsData: {
        isGoogleIntegrated: true,
        authorizationUrl: 'href://www.example.com'
      }
    })

    expect(wrapper.html()).to.include('Destroy google integration')
    expect(wrapper.html()).not.to.include('href://www.example.com')
  })

  it('shows the loading btn when loading === true and isGoogleIntegrated === true', () => {
    const wrapper = createWrapper(CalendarsGoogleSubscriptionBtn, {
      propsData: {
        loading: true,
        isGoogleIntegrated: true
      }
    })

    expect(wrapper.find('.spinner-border').exists()).to.be.true
  })

  it('shows the loading btn when loading === true and isGoogleIntegrated === false', () => {
    const wrapper = createWrapper(CalendarsGoogleSubscriptionBtn, {
      propsData: {
        loading: true,
        isGoogleIntegrated: false
      }
    })

    expect(wrapper.find('.spinner-border').exists()).to.be.true
  })

  it('does not show the loading btn when loading === false and isGoogleIntegrated === true', () => {
    const wrapper = createWrapper(CalendarsGoogleSubscriptionBtn, {
      propsData: {
        loading: false,
        isGoogleIntegrated: true
      }
    })

    expect(wrapper.find('.spinner-border').exists()).to.be.false
  })

  it('does not show the loading btn when loading === false and isGoogleIntegrated === false', () => {
    const wrapper = createWrapper(CalendarsGoogleSubscriptionBtn, {
      propsData: {
        loading: false,
        isGoogleIntegrated: false
      }
    })

    expect(wrapper.find('.spinner-border').exists()).to.be.false
  })

  it('does not show the loading btn when loading is not passed as prop', () => {
    const wrapper = createWrapper(CalendarsGoogleSubscriptionBtn)

    expect(wrapper.find('.spinner-border').exists()).to.be.false
  })
})
