import createWrapper from '../../helper'
import IssueExtraInformation from 'components/ticket-board/issue-extra-information'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('IssueExtraInformation', () => {
  const entry = sandbox.stub()
  const relationship = sandbox.stub()
  const factory = ({ propsData } = {}) => {
    return createWrapper(IssueExtraInformation, {
      propsData: {
        issueRef: {
          id: '1',
          type: 'issues'
        },
        ...propsData
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

  beforeEach(() => {
    const issue = {
      id: '1',
      type: 'issues',
      attributes: {
        title: 'Test title'
      },
      relationships: {
        labels: [{
          id: '1',
          type: 'labels'
        }]
      }
    }
    entry.withArgs({ id: '1', type: 'issues' }).returns(issue)
    relationship.withArgs(issue, 'labels').returns([{
      id: '1',
      type: 'labels',
      attributes: {
        name: 'Test label'
      }
    }])
  })

  afterEach(() => {
    sandbox.restore()
  })

  it('renders the component', () => {
    const wrapper = factory({
      propsData: {
        issueRef: {
          id: '1',
          type: 'issues'
        }
      }
    })

    expect(wrapper.html()).to.include('Test label')
  })
})
