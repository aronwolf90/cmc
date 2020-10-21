import createWrapper from '../../helper'
import TicketCreatedBy from 'components/ticket/created-by'
import RightAsideItem from 'components/right-aside-item'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('TicketCreatedBy', () => {
  const entry = sandbox.stub()
  const relationship = sandbox.stub()
  const issue = {
    id: '1',
    type: 'issues',
    relationships: {
      createdBy: {
        id: '1',
        type: 'users'
      }
    }
  }
  const user = {
    id: '1',
    type: 'users',
    attributes: {
      firstname: 'Lara',
      lastname: 'Croft'
    }
  }

  const factory = () => {
    return createWrapper(TicketCreatedBy, {
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
            entry,
            relationship
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
    relationship.withArgs(issue, 'created-by').returns(user)
    const wrapper = factory()

    expect(wrapper.findComponent(RightAsideItem).props()).to.eql({
      label: 'Created by',
      labelFor: undefined,
      text: 'Lara Croft'
    })
  })

  it('does not render the component when created-by is not present', () => {
    entry.withArgs({ id: '1', type: 'issues' }).returns(issue)
    relationship.withArgs(issue, 'created-by').returns(null)
    const wrapper = factory()

    expect(wrapper.html()).to.eq('')
  })
})
