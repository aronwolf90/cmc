import BtnDestroy from 'components/btn-destroy'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('components/btn-destroy.vue', () => {
  const entry = sandbox.stub()
  const user = {
    id: '1',
    type: 'users',
    meta: {
      permissions: {
        destroy: true
      }
    }
  }
  const factory = (options = {}) => {
    return createWrapper(BtnDestroy, {
      mocks: {
        $store: {
          getters: {
            entry
          }
        }
      },
      propsData: {
        entryId: '1',
        entryType: 'users',
        variant: 'outline-danger',
        size: 'sm'
      },
      slots: {
        default: '<i class="fa fa-trash">'
      },
      ...options
    })
  }

  beforeEach(() => {
    entry.withArgs({ id: '1', type: 'users' }).returns(user)
  })

  it('is rendered correctly', () => {
    const wrapper = factory()

    expect(wrapper.html()).to
      .eq('<button type="button" class="btn btn-outline-danger btn-sm"><i class="fa fa-trash"></i></button>')
  })

  it('is not rendered when meta.permissions.destroy === false', () => {
    const user = {
      id: '1',
      type: 'users',
      meta: {
        permissions: {
          destroy: false
        }
      }
    }

    entry.withArgs({ id: '1', type: 'users' }).returns(user)
    const wrapper = factory()

    expect(wrapper.html()).to.eq('')
  })

  it('emits destroy when is clicked and msgBoxConfirm resolved to true', async () => {
    const wrapper = factory()
    wrapper.vm.$bvModal.msgBoxConfirm = () => Promise.resolve(true)

    wrapper.trigger('click')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    expect(wrapper.emitted().destroy).to.eql([[]])
  })
})
