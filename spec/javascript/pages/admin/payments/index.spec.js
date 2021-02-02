import AdminPaymentsIndex from 'pages/admin/payments/index'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('AdminPaymentsIndex', () => {
  const dispatch = sandbox.stub()
  const subscription = {
    id: 'subscription',
    type: 'subscriptions',
    attributes: {
      'iban-last4': '2424',
      'premia': 5
    }
  }
  const invoice = {
    id: 'invoice_id',
    type: 'invoices',
    attributes: {
      'amount-paid': 800,
      'amount-due': 800,
      'amount-remaining': 0,
      pdf: 'https://pay.stripe.com/invoice/invst_9KtFtihugeF8KkYEfFEJltHcg7/pdf'
    }
  }
  const factory = () => {
    return createWrapper(AdminPaymentsIndex, {
      mocks: {
        $store: {
          dispatch
        }
      }
    })
  }

  beforeEach(() => {
    dispatch.withArgs('subscription')
      .returns(Promise.resolve({ data: subscription }))
    dispatch.withArgs('invoices')
      .returns(Promise.resolve({ data: [invoice] }))
  })

  it('render iban-last4', async () => {
    const wrapper = factory()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    expect(wrapper.html()).to.include('**** **** **** 2424')
    expect(wrapper.html()).not.to.include('spinner')
  })

  it('render premia', async () => {
    const wrapper = factory()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    expect(wrapper.html()).to.include('**** **** **** 2424')
  })

  it('render payment btn', () => {
    const wrapper = factory()

    expect(wrapper.html()).to.include('Add payment informations')
  })

  it('render invoice table headers', () => {
    const wrapper = factory()

    expect(wrapper.html()).to.include('Created at')
    expect(wrapper.html()).to.include('Amount paid')
    expect(wrapper.html()).to.include('Amount due')
    expect(wrapper.html()).to.include('Amount remaining')
  })

  it('render invoice table body', async () => {
    const wrapper = factory()

    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    expect(wrapper.html()).to.include('€8.00')
  })

  it('render invoice pdf link', async () => {
    const wrapper = factory()

    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    expect(wrapper.html()).to.include('https://pay.stripe.com/invoice/invst_9KtFtihugeF8KkYEfFEJltHcg7/pdf')
  })

  it('render spinner when loading subscription', async () => {
    dispatch.withArgs('subscription')
      .returns(new Promise(() => null))
    const wrapper = factory()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    expect(wrapper.html()).to.include('spinner')
  })

  it('render spinner when invoices are loading', () => {
    dispatch.withArgs('invoices')
      .returns(new Promise(() => null))
    const wrapper = factory()

    expect(wrapper.html()).to.include('spinner')
  })
})
