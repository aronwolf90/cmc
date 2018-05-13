import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ProjectSelect from '../../../app/javascript/board/project_select'
import { FormSelect } from 'bootstrap-vue/es/components'
import sinon from 'sinon'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(FormSelect)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('ProjectSelect', () => {
  subject(() => mount(ProjectSelect, { store: $store, localVue }))

  def('store', () => (new Vuex.Store({
    state: {},
    getters: {
      metaCollection () { return () => $projects },
      currentUser () { return $user },
      entry () { return () => $project }
    },
    actions: $actions
  })))
  def('actions', () => ({
    updateUser: sinon.spy()
  }))

  def('user', () => ({
    id: 1,
    type: 'users',
    relationships: {
      'selected-project': { data: null }
    }
  }))

  def('project', () => ({
    id: 1,
    type: 'projects',
    attributes: { name: 'project name' }
  }))

  describe('when the meta collection named projects is present ', () => {
    def('projects', () => ([$project]))

    it('general board option is present', () => {
      expect($subject.html()).to.include('General board')
    })

    it('project board option is present', () => {
      expect($subject.html()).to.include('project name')
    })

    it('call updateUser when value change', () => {
      $subject.find('select').element.value = 1
      $subject.find('select').trigger('change')

      expect($actions.updateUser).to.have.been.calledWith(
        sinon.match.any,
        { entry: $user, selectedProject: $project }
      )
    })

    describe('when the current user has an selected project', () => {
      def('user', () => ({
        id: 1,
        type: 'users',
        relationships: {
          'selected-project': { data: $project }
        }
      }))

      it('not call updateUser when value not change', () => {
        $subject.find('select').element.value = 1
        $subject.find('select').trigger('change')

        expect($actions.updateUser).to.not.have.been.calledWith(
          sinon.match.any,
          { entry: $user, selectedProject: $project }
        )
      })
    })
  })

  describe('when the meta collection named projects is empty ', () => {
    def('projects', () => [])

    it('general board option is present', () => {
      expect($subject.html()).to.include('General board')
    })
  })

  describe('when the meta collection named projects is not present ', () => {
    def('projects', () => undefined)

    it('general board option is present', () => {
      expect($subject.html()).to.be.undefined
    })
  })
})
