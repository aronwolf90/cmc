import createWrapper from '../../helper'
import CalendersGoogleSubscriptionBtn from '../../../../app/javascript/components/calenders/google-subscription-btn'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('CalendersGoogleSubscriptionBtn', () => {
  it('show  "Integrate with google calender" when isGoogleIntegrated is false', () => {
    const wrapper = createWrapper(CalendersGoogleSubscriptionBtn, {
      propsData: {
        isGoogleIntegrated: false
      }
    })

    expect(wrapper.html()).to.include('Integrate with google calender')
  })

  it('show  "Cancel google calender integration" when isGoogleIntegrated< is true', () => {
    const wrapper = createWrapper(CalendersGoogleSubscriptionBtn, {
      propsData: {
        isGoogleIntegrated: true
      }
    })

    expect(wrapper.html()).to.include('Is integrated with google calender')
  })
})
