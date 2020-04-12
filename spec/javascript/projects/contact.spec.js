import { mount, createLocalVue } from '@vue/test-utils'
import Contact from '../../../app/javascript/components/projects/contact'
import DetailsStringInput from '../../../app/javascript/components/details-string-input'
import BootstrapVue from 'bootstrap-vue'
import Vuex from 'vuex'
import sinon from 'sinon'

const localVue = createLocalVue()
localVue.use(Vuex)
localVue.use(BootstrapVue)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('DetailsStringInput', () => {
  const sandbox = sinon.sandbox.create()
  const contact = { id: 1, type: 'contacts' }
  const updateContact = sandbox.stub()
  const contactTelephoneNumberValue = sandbox.stub()
  const emailValue = sandbox.stub()
  const store = {
    modules: {
      projectsShow: {
        namespaced: true,
        mutations: {
          contactTelephoneNumberValue,
          emailValue
        },
        getters: {
          contact () {
            return contact
          },
          contactNameValue () {
            return 'project'
          },
          contactNameEditMode () {
            return false
          },
          contactTelephoneNumberValue () {
            return '+49 821 598-1111'
          },
          contactTelephoneNumberEditMode () {
            return false
          },
          contactEmailValue () {
            return 'aron.wolf@test.com'
          },
          contactEmailEditMode () {
            return false
          }
        }
      }
    },
    actions: {
      updateContact
    }
  }

  afterEach(() => (sandbox.restore()))

  describe('telephone', () => {
    it('pass telephone value to component', () => {
      const wrapper = mount(Contact, {
        localVue,
        store: new Vuex.Store(store)
      })
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(1)

      expect(detailsStringInput.props().value)
        .to.eql('+49 821 598-1111')
    })

    it('call commit("projectsShow/contactTelephoneNumberValue", value) ', () => {
      const wrapper = mount(Contact, {
        localVue,
        store: new Vuex.Store(store),
        stubs: {
          DetailsStringInput
        }
      })
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(1)

      detailsStringInput.vm.value = 'hi'
      detailsStringInput.trigger('input')
      expect(contactTelephoneNumberValue).to.have.been.called
    })

    it('handle submit', (done) => {
      const wrapper = mount(Contact, {
        localVue,
        store: new Vuex.Store(store),
        stubs: {
          DetailsStringInput
        }
      })
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(1)

      detailsStringInput.trigger('submit')
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(detailsStringInput.vm.editMode).to.eq(false)
          expect(updateContact).to.have.been.calledWith(sinon.match.any, {
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
      const wrapper = mount(Contact, {
        localVue,
        store: new Vuex.Store(store)
      })
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(2)

      expect(detailsStringInput.vm.value)
        .to.eql('aron.wolf@test.com')
    })

    it('call commit("projectsShow/emailValue", value) ', () => {
      const wrapper = mount(Contact, {
        localVue,
        store: new Vuex.Store(store),
        stubs: {
          DetailsStringInput
        }
      })
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(2)

      detailsStringInput.vm.value = 'hi'
      detailsStringInput.trigger('input')
      expect(contactTelephoneNumberValue).to.have.been.called
    })

    it('handle submit', (done) => {
      const wrapper = mount(Contact, {
        localVue,
        store: new Vuex.Store(store),
        stubs: {
          DetailsStringInput
        }
      })
      const detailsStringInput =
        wrapper.findAll(DetailsStringInput).at(2)

      detailsStringInput.trigger('submit')
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(detailsStringInput.vm.editMode).to.eq(false)
          expect(updateContact).to.have.been.calledWith(sinon.match.any, {
            entry: contact,
            payload: {
              attributes: {
                email: 'aron.wolf@test.com'
              }
            }
          })
          done()
        })
      })
    })
  })
})
