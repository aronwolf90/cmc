import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import BootstrapVue from 'bootstrap-vue'
import VueRouter from 'vue-router'

const localVue = createLocalVue()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

export default (element, options = {}) => {
  const router = new VueRouter()
  const store = options['store']

  if (router.path !== '/') {
    router.push('/')
  }

  delete options.store
  return mount(element, {
    router,
    localVue,
    mocks: {
      $store: store
    },
    ...options
  })
}
