import { shallow, createLocalVue } from '@vue/test-utils'
import LeftAsideItem from '../../../app/javascript/components/left-aside-item'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(VueRouter)

/* eslint-disable no-undef, no-unused-expressions */

describe('LeftAsideItem', () => {
  describe('is not the current one', () => {
    it('do not have active class', () => {
      const wrapper = shallow(LeftAsideItem, {
        router,
        localVue,
        propsData: { path: '/test' }
      })
      expect(wrapper.find('.active').exists()).to.be.false
    })
  })
})
