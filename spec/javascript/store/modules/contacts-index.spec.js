import ContactsIndexModule from 'store/modules/contacts-index.js'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('store/modules/contacts-index.js', () => {
  const contact = {
    id: '1',
    type: 'contacts',
    attributes: {
      name: 'Lara Croft'
    }
  }

  it('actions.fetch', async () => {
    const dispatch = sandbox.stub()
    const commit = sandbox.stub()
    const response = {
      data: [contact],
      meta: { count: 1 }
    }

    dispatch.withArgs('get', 'contacts').returns(Promise.resolve(response))
    await ContactsIndexModule.actions.fetch({ dispatch, commit })

    expect(commit).to.have.been.calledWith('contacts', [contact])
  })

  it('mutations.contacts', () => {
    const state = {}

    ContactsIndexModule.mutations.contacts(state, [contact])

    expect(state).to.eql({ contactRefs: [{ id: '1', type: 'contacts' }] })
  })

  it('getters.contacts', () => {
    const state = { contactRefs: [{ id: '1', type: 'contacts' }] }
    const entry = sandbox.stub()

    entry.withArgs({ id: '1', type: 'contacts' }).returns(contact)

    expect(ContactsIndexModule.getters.contacts(
      state, null, null, { entry }
    )).to.eql([contact])
  })
})
