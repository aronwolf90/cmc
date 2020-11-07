import ShowBtnDestroy from 'components/show-btn-destroy'
import BtnDestroy from 'components/btn-destroy'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('components/show-btn-destroy.vue', () => {
  const factory = (options = {}) => {
    return createWrapper(ShowBtnDestroy, {
      stubs: {
        'btn-destroy': true
      },
      propsData: {
        entryRef: {
          id: '1',
          type: 'users'
        }
      },
      ...options
    })
  }

  it('pass correctly props to btn-destroy', () => {
    const wrapper = factory()

    expect(wrapper.findComponent(BtnDestroy).props()).to.eql({
      entryId: '1',
      entryType: 'users',
      size: 'sm',
      variant: 'outline-danger'
    })
  })

  it('forwards the destroy event', () => {
    const wrapper = factory()

    wrapper.findComponent(BtnDestroy).vm.$emit('destroy')

    expect(wrapper.emitted().destroy).to.exist
  })
})
