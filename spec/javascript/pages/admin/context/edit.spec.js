import Edit from 'pages/admin/context/edit'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('pages/admin/context/edit.vue', () => {
  const context = {
    id: 1,
    type: 'contexts',
    attributes: {
      'time-zone': 'Berlin',
      'global-board': false
    }
  }
  const dispatch = sandbox.stub()
  const factory = () => {
    return createWrapper(Edit, {
      mocks: {
        $store: {
          dispatch,
          getters: {
            context
          }
        }
      },
      attachToDocument: true
    })
  }

  beforeEach(() => {
    dispatch.returns(Promise.resolve())
    dispatch.withArgs('getContext')
      .returns(Promise.resolve({ data: context }))
  })
  afterEach(() => sandbox.restore())

  it('set attributes from context', async () => {
    const wrapper = factory()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    expect(wrapper.vm.form.attributes).to.eql({ 'time-zone': 'Berlin', 'global-board': false })
  })

  it('calls updateOrganization when submit is clicked', async () => {
    const wrapper = factory()
    wrapper.findAll('option').at(1).element.selected = true
    wrapper.find('select').trigger('change')
    wrapper.find('input[type="checkbox"]').trigger('click')
    wrapper.find('input[type="checkbox"]').trigger('change')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    sandbox.stub(window.location, 'replace')
    wrapper.find('[type="submit"]').trigger('click')
  })

  it('calls location.replate when no error is present', async () => {
    const wrapper = factory()
    wrapper.findAll('option').at(1).element.selected = true
    wrapper.find('select').trigger('change')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    sandbox.stub(window.location, 'replace')
    wrapper.find('[type="submit"]').trigger('click')
  })

  it('show errors when they are present', async () => {
    const wrapper = factory()
    dispatch.withArgs('updateContext').returns(Promise.reject({
      status: 'fail',
      data: { errors: [{ source: { pointer: 'attributes/time-zone' } }] }
    }))
    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    expect(wrapper.vm.errors).to.eql([{ source: { pointer: 'attributes/time-zone' } }])
  })
})
