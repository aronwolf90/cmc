import createWrapper from '../../helper'
import TicketCreatedAt from 'components/ticket/created-at'
import RightAsideItem from 'components/right-aside-item'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('components/ticket/created-at.vue', () => {
  const entry = sandbox.stub()
  const issue = {
    id: '1',
    type: 'issues',
    attributes: {
      'created-at': '10-10-2020 10:10'
    }
  }
  const factory = () => {
    return createWrapper(TicketCreatedAt, {
      stubs: {
        'right-aside-item': true
      },
      propsData: {
        issueRef: {
          id: '1',
          type: 'issues'
        }
      },
      mocks: {
        $store: {
          getters: {
            entry
          }
        }
      }
    })
  }

  afterEach(() => {
    sandbox.restore()
  })

  it('renders the component correctly', () => {
    entry.withArgs({ id: '1', type: 'issues' }).returns(issue)
    const wrapper = factory()

    expect(wrapper.findComponent(RightAsideItem).props()).to.eql({
      label: 'Created at',
      labelFor: undefined,
      text: '10-10-2020 10:10'
    })
  })

  it('does not render the component when issue is not present', () => {
    entry.withArgs({ id: '1', type: 'issues' }).returns(null)
    const wrapper = factory()

    expect(wrapper.html()).to.eq('')
  })
})
