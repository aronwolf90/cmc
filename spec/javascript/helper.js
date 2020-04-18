import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import BootstrapVue from 'bootstrap-vue'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

export default (element, options) => {
  const store = options['store']
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
