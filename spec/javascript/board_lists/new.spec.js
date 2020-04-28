import createWrapper from '../../helper'
import BoardListNew from '../../../app/javascript/board_lists/new'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('BoardListNew', () => {
  const dispatch = sandbox.stub()
  const commit = sandbox.stub()
  const store = {
    dispatch,
    commit
  }
  const factory = () => {
    return createWrapper(BoardListNew, {
      store,
      stubs: { DetailsStringInput }
    })
  }

  it('calls createBoardList when submit is clicked', (done) => {
    const wrapper = factory()
    wrapper.find('[type="submit"]').trigger('click')
    expect(disptach).to.have.been.calledWith('createBoardList')
  })
})
