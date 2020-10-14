import createWrapper from '../../helper'
import Contact from '../../../../app/javascript/components/projects/contact'
import DetailsStringInput from '../../../../app/javascript/components/details-string-input'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('DetailsStringInput', () => {
  const contactRef = { id: 1, type: 'contacts' }
  const contact = {
    id: 1,
    type: 'contacts',
    attributes: {
      name: 'Test'
    }
  }
  const dispatch = sandbox.stub()
  const commit = sandbox.stub()
  const entry = sandbox.stub()
  const store = {
    dispatch,
    commit,
    getters: {
      'projectsShow/contact': contactRef,
      'projectsShow/contacts': [contactRef],
      'projectsShow/contactIdValue': { id: 1, type: 'contacts' },
      'projectsShow/contactIdEditMode': false,
      'projectsShow/contactNameValue': 'project',
      'projectsShow/contactNameEditMode': false,
      'projectsShow/contactTelephoneNumberValue': '+49 821 598-1111',
      'projectsShow/contactTelephoneNumberEditMode': false,
      'projectsShow/contactEmailValue': 'aron.wolf@test.com',
      'projectsShow/contactEmailEditMode': false,
      entry
    }
  }

  beforeEach(() => {
    entry.returns(contact)
  })

  afterEach(() => {
    sandbox.restore()
    dispatch.returns(Promise.resolve())
  })

  const factory = ({ stubs } = {}) => {
    return createWrapper(Contact, {
      store,
      stubs: {
        DetailsStringInput,
        ...stubs
      }
    })
  }

  describe('header', () => {
    it('render header', () => {
      const wrapper = factory({
        stubs: { 'details-select-header-input': true }
      })
      const header = wrapper.find('details-select-header-input-stub')

      header.vm.$emit('search', 'test', () => {})

      expect(header.props().text)
        .to.eq('Contact')
      expect(header.props().options)
        .to.eql([{ id: 1, type: 'contacts' }])
      expect(header.props().getOptionLabel({ id: 1, type: 'contacts' }))
        .to.eql('Test')
      expect(dispatch)
        .to.have.been.calledWith('projectsShow/searchForContact', 'test')
    })
  })

  describe('telephone', () => {
    it('pass telephone value to component', () => {
      const wrapper = createWrapper(Contact, { store, stubs: { DetailsStringInput } })
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(1)

      expect(detailsStringInput.props().value)
        .to.eql('+49 821 598-1111')
    })

    it('handle submit', (done) => {
      const wrapper = factory()
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(1)

      detailsStringInput.trigger('submit')
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(detailsStringInput.vm.editMode).to.eq(false)
          expect(dispatch).to.have.been.calledWith('updateContact', {
            entry: contactRef,
            payload: {
              attributes: {
                telephone: '+49 821 598-1111'
              }
            }
          })
          done()
        })
      })
    })
  })

  describe('email', () => {
    it('pass email value to component', () => {
      const wrapper = factory()
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(2)

      expect(detailsStringInput.vm.value)
        .to.eql('aron.wolf@test.com')
    })

    it('handle submit', (done) => {
      const wrapper = factory()
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(2)

      detailsStringInput.trigger('submit')
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(detailsStringInput.vm.editMode).to.eq(false)
          expect(dispatch).to.have.been.calledWith(
            'updateContact', {
              entry: contactRef,
              payload: {
                attributes: {
                  email: 'aron.wolf@test.com'
                }
              }
            }
          )
          done()
        })
      })
    })
  })
})
