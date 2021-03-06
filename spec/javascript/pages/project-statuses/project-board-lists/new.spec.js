import ProjectBoardListNew from 'pages/project-statuses/_id/project-board-lists/new'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('pages/project-statuses/project-board-lists/new.vue', () => {
  afterEach(() => sandbox.restore())

  it('calls createProjectBoardList when submit is clicked', async () => {
    const dispatch = sandbox.stub()
    dispatch.returns(Promise.resolve())
    let wrapper = createWrapper(ProjectBoardListNew, {
      mocks: {
        $store: {
          dispatch
        }
      },
      attachToDocument: true
    })
    wrapper.find('#input-name').element.value = 'New'
    wrapper.find('#input-name').trigger('input')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()
    expect(dispatch).to.have.been.calledWith('createProjectBoardList', {
      attributes: { name: 'New' },
      relationships: {
        'project-status': {
          data: {
            id: this.projectStatusId,
            type: 'project-statuses'
          }
        }
      }
    })
  })

  it('show errors when they are present', async () => {
    const dispatch = sandbox.stub()
    dispatch.returns(
      Promise.reject({
        status: 'fail',
        data: {
          errors: [{ source: { pointer: 'attributes/name' } }]
        }
      })
    )
    let wrapper = createWrapper(ProjectBoardListNew, {
      mocks: {
        $store: {
          dispatch
        }
      },
      attachToDocument: true
    })
    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    expect(wrapper.vm.errors).to.eql([{ source: { pointer: 'attributes/name' } }])
  })
})
