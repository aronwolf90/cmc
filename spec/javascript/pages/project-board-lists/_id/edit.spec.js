import PagesProjectBoardListsIdEdit from 'pages/project-board-lists/_id/edit'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('pages/project-board-lists/_id/edit.vue', () => {
  const projectBoardList = {
    id: 1,
    type: 'project-board-lists',
    attributes: {
      name: 'New'
    },
    relationships: {
      'project-status': {
        data: { id: 1, type: 'project-statuses' }
      }
    },
    meta: {
      permissions: {
        destroy: true
      }
    }
  }
  const dispatch = sandbox.stub()
  const factory = () => {
    return createWrapper(PagesProjectBoardListsIdEdit, {
      mocks: {
        $store: {
          dispatch,
          getters: {
            projectBoardList: () => projectBoardList
          }
        }
      },
      attachToDocument: true
    })
  }

  beforeEach(() => {
    dispatch.returns(Promise.resolve())
    dispatch.withArgs('getProjectBoardList').returns(
      Promise.resolve({ data: projectBoardList }))
  })

  it('calls updateProjectBoardList when submit is clicked', async () => {
    const wrapper = factory()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    wrapper.find('#input-name').element.value = 'New'
    wrapper.find('#input-name').trigger('input')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()
    expect(dispatch).to.have.been.calledWith('updateProjectBoardList', {
      projectBoardList: projectBoardList,
      payload: {
        attributes: {
          name: 'New'
        }
      }
    })
  })

  it('initialize inputs', async () => {
    const wrapper = factory()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    expect(wrapper.find('#input-name').element.value).to.eq('New')
  })

  it('show errors when they are present', async () => {
    const wrapper = factory()
    dispatch.withArgs('updateProjectBoardList').returns(
      Promise.reject({
        status: 'fail',
        data: {
          errors: [{ source: { pointer: 'attributes/name' } }]
        }
      })
    )
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    expect(wrapper.vm.errors).to.eql([{ source: { pointer: 'attributes/name' } }])
  })
})
