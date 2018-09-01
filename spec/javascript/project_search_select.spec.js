import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ProjectSearchSelect from '../../app/javascript/project_search_select'
import { FormInput } from 'bootstrap-vue/es/components'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(FormInput)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('ProjectSearchSelect', () => {
  subject(() => mount(ProjectSearchSelect, { store: $store, localVue }))

  def('getters', () => ({
    relevantProjects () {
      return (value) => {
        if (value === 'project1') {
          return [$project1]
        } else if (value === 'project2') {
          return [$project2]
        }
        return []
      }
    },
    entry () {
      return ({ id }) => {
        if (id === 1) {
          return $project1
        } else if (id === 2) {
          return $project2
        }
      }
    }
  }))
  def('actions', () => ({ initBoardsLists () {} }))
  def('store', () => (new Vuex.Store({
    state: {},
    getters: $getters,
    actions: $actions
  })))
  def('project1', () => ({
    id: 1,
    type: 'projects',
    attributes: { name: 'project1' }
  }))
  def('project2', () => ({
    id: 2,
    type: 'projects',
    attributes: { name: 'project2' }
  }))
  describe('when write into input project1', () => {
    it('show project1', (done) => {
      let input = $subject.find('input')
      input.element.value = 'project1'
      input.trigger('input')
      input.trigger('focus')
      $subject.vm.$nextTick(() => {
        expect($subject.html()).to.include('project1')
        done()
      })
    })
  })

  describe('when write into input project2', () => {
    it('show project2', (done) => {
      let input = $subject.find('input')
      input.element.value = 'project2'
      input.trigger('input')
      input.trigger('focus')
      $subject.vm.$nextTick(() => {
        expect($subject.html()).to.include('project2')
        done()
      })
    })
  })
})
