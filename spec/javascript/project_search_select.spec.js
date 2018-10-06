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
    metaCollection () {
      return () => [$project]
    },
    entry () {
      return ({ id }) => {
        return $project
      }
    }
  }))
  def('actions', () => ({
    initProjects () {},
    request () {}
  }))
  def('store', () => (new Vuex.Store({
    state: {},
    getters: $getters,
    actions: $actions
  })))
  def('project', () => ({
    id: 1,
    type: 'projects',
    attributes: { name: 'project1' }
  }))

  it('show project', (done) => {
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
