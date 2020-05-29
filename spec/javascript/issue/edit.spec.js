import createWrapper from '../helper'
import EditIssue from '../../../app/javascript/issue/edit'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('EditIssue', () => {
  const dispatch = sandbox.stub()

  afterEach(() => {
    sandbox.restore()
  })

  it('have title input', (done) => {
    dispatch.returns(Promise.resolve())
    const issue = {
      id: 1,
      type: 'issues',
      attributes: {
        title: 'Test'
      }
    }
    const wrapper = createWrapper(EditIssue, {
      stubs: {
        'markdown-editor': true
      },
      mocks: {
        $store: {
          dispatch,
          getters: {
            entry: () => issue
          }
        }
      }
    })

    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(wrapper.find('input#name-input').exists()).to.be.true
          done()
        })
      })
    })
  })
})
