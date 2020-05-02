import createWrapper from '../../helper'
import Contact from '../../../../app/javascript/components/projects/contact'
import DetailsStringInput from '../../../../app/javascript/components/details-string-input'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('DetailsStringInput', () => {
  const contact = { id: 1, type: 'contacts' }
  const dispatch = sandbox.stub()
  const commit = sandbox.stub()
  const store = {
    dispatch,
    commit,
    getters: {
      'projectsShow/contact': contact,
      'projectsShow/contacts': [contact],
      'projectsShow/contactIdValue': { id: 1, type: 'contacts' },
      'projectsShow/contactIdEditMode': false,
      'projectsShow/contactNameValue': 'project',
      'projectsShow/contactNameEditMode': false,
      'projectsShow/contactTelephoneNumberValue': '+49 821 598-1111',
      'projectsShow/contactTelephoneNumberEditMode': false,
      'projectsShow/contactEmailValue': 'aron.wolf@test.com',
      'projectsShow/contactEmailEditMode': false
    }
  }

  afterEach(() => {
    sandbox.restore()
    dispatch.returns(Promise.resolve())
  })
  const factory = () => {
    return createWrapper(Contact, { store, stubs: { DetailsStringInput } })
  }

  describe('telephone', () => {
    it('pass telephone value to component', () => {
      const wrapper = createWrapper(Contact, { store, stubs: { DetailsStringInput } })
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(2)

      expect(detailsStringInput.props().value)
        .to.eql('+49 821 598-1111')
    })

    it('call commit("projectsShow/contactTelephoneNumberValue", value) ', () => {
      const wrapper = factory()
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(2)

      detailsStringInput.vm.value = 'hi'
      detailsStringInput.trigger('input')
      expect(commit).to.have.been.calledWith('projectsShow/contactTelephoneNumberValue')
    })

    it('handle submit', (done) => {
      const wrapper = factory()
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(2)

      detailsStringInput.trigger('submit')
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(detailsStringInput.vm.editMode).to.eq(false)
          expect(dispatch).to.have.been.calledWith('updateContact', {
            entry: contact,
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
        wrapper.findAll(DetailsStringInput).at(3)

      expect(detailsStringInput.vm.value)
        .to.eql('aron.wolf@test.com')
    })

    it('call commit("projectsShow/emailValue", value) ', () => {
      const wrapper = factory()
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(3)

      detailsStringInput.vm.value = 'hi'
      detailsStringInput.trigger('input')
      expect(commit).to.have.been
        .calledWith('projectsShow/contactTelephoneNumberValue')
    })

    it('handle submit', (done) => {
      const wrapper = factory()
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(3)

      detailsStringInput.trigger('submit')
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(detailsStringInput.vm.editMode).to.eq(false)
          expect(dispatch).to.have.been.calledWith(
            'updateContact', {
              entry: contact,
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
