import ProjectStatusNew from 'pages/project-statuses/_id/edit'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('pages/project-statuses/_id/edit.vue', () => {
  const projectStatus = {
    id: 1,
    type: 'project-statuses',
    attributes: {
      name: 'New',
      'display-as': 'list'
    },
    meta: {
      permissions: {
        destroy: true,
        create: true
      }
    }
  }
  const dispatch = sandbox.stub()
  const factory = () => {
    return createWrapper(ProjectStatusNew, {
      mocks: {
        $store: {
          dispatch,
          getters: {
            projectStatus: () => projectStatus
          }
        }
      },
      attachToDocument: true
    })
  }

  beforeEach(() => {
    dispatch.returns(Promise.resolve())
    dispatch.withArgs('getProjectStatus')
      .returns(Promise.resolve({ data: projectStatus }))
  })

  it('calls updateProjectStatus when submit is clicked', async () => {
    const wrapper = factory()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    wrapper.find('#input-name').trigger('input')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    wrapper.find('[type="submit"]').trigger('click')
    expect(dispatch).to.have.been.calledWith('updateProjectStatus', {
      projectStatus,
      payload: {
        attributes: {
          name: 'New',
          'display-as': 'list'
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
    dispatch.withArgs('updateProjectStatus').returns(
      Promise.reject({
        status: 'fail',
        data: {
          errors: [{ source: { pointer: 'attributes/name' } }]
        }
      })
    )
    const wrapper = factory()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    expect(wrapper.vm.errors).to.eql([{ source: { pointer: 'attributes/name' } }])
  })
})
