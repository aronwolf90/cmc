import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ProjectStatusNew from '../../../app/javascript/project-statuses/edit'
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

describe('ProjectStatusNew', () => {
  const projectStatus = {
    id: 1,
    type: 'project-statuses',
    attributes: {
      name: 'New'
    }
  }
  const store = {
    actions: {
      getProjectStatus () {
        return Promise.resolve({ data: projectStatus })
      },
      updateProjectStatus (_, { attributes }) {
        return Promise.resolve()
      }
    }
  }

  it('calls updateProjectStatus when submit is clicked', (done) => {
    store.actions['updateProjectStatus'] = (_, { attributes }) => {
      expect(attributes).to.eql({ name: 'New' })
      done()
      return Promise.resolve()
    }
    const wrapper = mount(ProjectStatusNew, {
      router,
      store: new Vuex.Store(store),
      localVue,
      attachToDocument: true
    })
    wrapper.find('#input-name').element.value = 'New'
    wrapper.find('#input-name').trigger('input')
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.find('[type="submit"]').trigger('click')
      })
    })
  })

  it('initialize inputs', (done) => {
    const wrapper = mount(ProjectStatusNew, {
      router,
      store: new Vuex.Store(store),
      localVue
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.find('#input-name').element.value).to.eq('New')
        done()
      })
    })
  })

  it('show errors when they are present', (done) => {
    store.actions['updateProjectStatus'] = (_, { attributes }) => {
      return Promise.reject({
        status: 'fail',
        data: {
          errors: [{ source: { pointer: 'attributes/name' } }]
        }
      })
    }
    const wrapper = mount(ProjectStatusNew, {
      store: new Vuex.Store(store),
      localVue,
      attachToDocument: true
    })
    wrapper.find('[type="submit"]').trigger('click')
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(wrapper.vm.errors).to.eql([{ source: { pointer: 'attributes/name' } }])
          done()
        })
      })
    })
  })
})
