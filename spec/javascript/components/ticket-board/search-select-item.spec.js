import createWrapper from '../../helper'
import BoardSearchSelectItem from 'components/ticket-board/search-select-item'
import SearchSelectItem from 'components/search-select-item'
import IssueExtraInformation from 'components/ticket-board/issue-extra-information'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('BoardSearchSelectItem', () => {
  it('renders the component', () => {
    const entry = sandbox.stub()
    entry.withArgs({ id: '1', type: 'issues' }).returns({
      id: '1',
      type: 'issues',
      attributes: {
        title: 'Test title'
      }
    })
    const wrapper = createWrapper(BoardSearchSelectItem, {
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
      },
      stubs: {
        SearchSelectItem: true,
        IssueExtraInformation: true
      }
    })

    expect(wrapper.findComponent(SearchSelectItem).props().title).to.eq('Test title')
    expect(wrapper.findComponent(SearchSelectItem).props().link).to.eq('issues/1')
    expect(wrapper.findComponent(IssueExtraInformation).props().issueRef).to.eql({ id: '1', type: 'issues' })
  })
})
