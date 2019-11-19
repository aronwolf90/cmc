import { shallow, createLocalVue } from '@vue/test-utils'
import AsyncComputed from 'vue-async-computed'
import Vuex from 'vuex'
import AdminPaymentsIndex from '../../../../app/javascript/admin/payments/index'
const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(AsyncComputed)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('AdminPaymentsIndex', () => {
  subject(() => shallow(AdminPaymentsIndex,
    { store: $store, localVue, propsData: {} }))

  def('actions', () => ({
    invoices () {
      return Promise.resolve({
        data: [{
          id: 'invoice_id',
          type: 'invoices',
          attributes: {
            'amount-paid': 8,
            'amount-due': 8,
            'amount-remaining': 0
          }
        }]
      })
    }
  }))
  def('store', () => (new Vuex.Store({ state: {}, actions: $actions })))

  it('render payment btn', () => {
    expect($subject.html()).to.include('Add payment informations')
  })

  it('render invoice table headers', () => {
    expect($subject.html()).to.include('Created at')
    expect($subject.html()).to.include('Amount paid')
    expect($subject.html()).to.include('Amount due')
    expect($subject.html()).to.include('Amount remaining')
  })

  it('render invoice table body', (done) => {
    $subject.vm.$nextTick(() => {
      $subject.vm.$nextTick(() => {
        expect($subject.html()).to.include(8)
        done()
      })
    })
  })
})
