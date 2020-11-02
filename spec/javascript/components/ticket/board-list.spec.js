import createWrapper from '../../helper'
import TicketBoardList from 'components/ticket/board-list'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('components/ticket/board-list.vue', () => {
  const entry = sandbox.stub()
  const relationship = sandbox.stub()
  const dispatch = sandbox.stub()
  const issue = {
    id: '1',
    type: 'issues',
    relationships: {
      'board-list': {
        id: '1',
        type: 'board-lists'
      }
    }
  }
  const boardList = {
    id: '1',
    type: 'board-lists',
    attributes: {
      name: 'In progress'
    }
  }

  const factory = () => {
    return createWrapper(TicketBoardList, {
      stubs: {
        'right-aside-select': true
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
            relationship,
            'issuesShow/boardLists': [boardList]
          },
          dispatch
        }
      }
    })
  }

  afterEach(() => {
    sandbox.restore()
  })

  it('renders the component correctly', () => {
    entry.withArgs({ id: '1', type: 'issues' }).returns(issue)
    relationship.withArgs(issue, 'board-list').returns(boardList)
    const wrapper = factory()

    expect(wrapper.find('right-aside-select-stub').props()).to.eql({
      label: 'Board list',
      item: {
        text: 'In progress',
        value: { id: '1', type: 'board-lists' }
      },
      options: [
        {
          text: 'In progress',
          value: {
            id: '1',
            type: 'board-lists'
          }
        }
      ]
    })
  })

  it('calls issuesShow/updateBoardList correctly when select is emited', () => {
    entry.withArgs({ id: '1', type: 'issues' }).returns(issue)
    entry.withArgs({ id: '1', type: 'board-lists' }).returns(boardList)
    relationship.withArgs(issue, 'board-list').returns(boardList)
    const wrapper = factory()

    const eventData = {
      text: 'In progress',
      value: { id: '1', type: 'board-lists' }
    }
    wrapper.find('right-aside-select-stub').vm.$emit('select', eventData)

    expect(dispatch).to.have.been.calledWith('issuesShow/updateBoardList', boardList)
  })

  it('does not render the component when created-by is not present', () => {
    entry.withArgs({ id: '1', type: 'issues' }).returns(issue)
    relationship.withArgs(issue, 'board-list').returns(null)
    const wrapper = factory()

    expect(wrapper.html()).to.eq('')
  })
})
