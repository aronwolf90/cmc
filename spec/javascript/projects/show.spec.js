import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ProjectShow from '../../../app/javascript/projects/show'
import BootstrapVue from 'bootstrap-vue'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('ProjectShow', () => {
  const project = {
    id: 1,
    type: 'projects',
    attributes: {
      name: 'Test'
    }
  }

  const store = {
    getters: {
      project () {
        return () => project
      }
    },
    actions: {
      getProject () {
        return Promise.resolve({ data: project })
      }
    }
  }

  it('renders the title', (done) => {
    const wrapper = mount(ProjectShow, {
      router,
      store: new Vuex.Store(store),
      localVue,
      stubs: {
        comments: true
      }
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.html()).to.include('Test')
        done()
      })
    })
  })

  it('renders the edit btn', (done) => {
    const wrapper = mount(ProjectShow, {
      router,
      store: new Vuex.Store(store),
      localVue,
      stubs: {
        comments: true
      }
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.find('.fa-edit').exists()).to.be.true
        done()
      })
    })
  })

  it('calls destroyProject when fa-trash is clicked', (done) => {
    store.actions['destroyProject'] = () => {
      done()
    }
    const wrapper = mount(ProjectShow, {
      router,
      store: new Vuex.Store(store),
      localVue,
      stubs: {
        comments: true
      }
    })
    wrapper.find('.fa-trash').trigger('click')
  })
})
