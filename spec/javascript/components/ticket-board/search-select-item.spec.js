import createWrapper from '../../helper'
import BoardSearchSelectItem from 'components/ticket-board/search-select-item'
import SearchSelectItem from 'components/search-select-item'
import IssueExtraInformation from 'components/ticket-board/issue-extra-information'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('BoardSearchSelectItem', () => {
  const entry = sandbox.stub()
  const factory = ({ propsData } = {}) => {
    return createWrapper(BoardSearchSelectItem, {
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
            entry
          }
        }
      },
      stubs: {
        SearchSelectItem: true,
        IssueExtraInformation: true
      }
    })
  }

  beforeEach(() => {
    entry.withArgs({ id: '1', type: 'issues' }).returns({
      id: '1',
      type: 'issues',
      attributes: {
        title: 'Test title'
      }
    })
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

    expect(wrapper.findComponent(SearchSelectItem).props().title).to.eq('Test title')
    expect(wrapper.findComponent(SearchSelectItem).props().link).to.eq('issues/1')
    expect(wrapper.findComponent(IssueExtraInformation).props().issueRef).to.eql({ id: '1', type: 'issues' })
  })

  it('renders the component', () => {
    const wrapper = factory({
      propsData: {
        issueRef: null
      }
    })

    expect(wrapper.html()).to.eq('')
  })
})
