import DueAt from 'components/ticket/due-at'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('DueAt', () => {
  it('call updateIssue when submit button is clicked', async () => {
    const issue = { attributes: { 'due-at': '10-10-2020 00:00' } }
    const dispatch = sandbox.stub()
    dispatch.returns(Promise.resolve())
    dispatch.withArgs('initIssue').returns(Promise.resolve({ data: issue }))
    const wrapper = createWrapper(DueAt, {
      mocks: {
        $store: {
          dispatch,
          getters: {
            issue: () => issue
          }
        }
      },
      attachToDocument: true
    })
    wrapper.vm.$nextTick()
    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    expect(dispatch).to.have.been.calledWith('updateIssue', {
      entry: issue,
      attributes: {
        'due-at': '10-10-2020 00:00'
      }
    })
  })

  it('show spinner when waiting for updateIssue Promise', async () => {
    const issue = { attributes: { 'due-at': '10-10-2020 00:00' } }
    let promiseResolve = null
    const dispatch = sandbox.stub()
    const promise = new Promise((resolve) => {
      promiseResolve = resolve
    })
    dispatch.returns(Promise.resolve())
    dispatch.withArgs('initIssue').returns(Promise.resolve({ data: issue }))
    dispatch.withArgs('updateIssue').returns(promise)
    const wrapper = createWrapper(DueAt, {
      mocks: {
        $store: {
          dispatch,
          getters: {
            issue: () => issue
          }
        }
      },
      attachToDocument: true
    })
    await wrapper.vm.$nextTick()
    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()
    expect(wrapper.find('.fa-spinner').exists()).to.be.true
    promiseResolve()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    expect(wrapper.find('.fa-spinner').exists()).to.be.false
  })
})
