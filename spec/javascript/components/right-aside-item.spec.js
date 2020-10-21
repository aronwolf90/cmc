import createWrapper from '../helper'
import RightAsideItem from 'components/right-aside-item'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('RightAsideItem', () => {
  it('renders the component correctly', () => {
    const wrapper = createWrapper(RightAsideItem, {
      propsData: {
        label: 'Created by',
        text: 'Lara Croft'
      }
    })

    expect(wrapper.html()).to.include('Created by')
    expect(wrapper.html()).to.include('Lara Croft')
  })

  it('renders the header slot', () => {
    const wrapper = createWrapper(RightAsideItem, {
      slots: {
        header: '<header-slot></header-slot>'
      }
    })

    expect(wrapper.html()).to.include('header-slot')
  })

  it('renders the content slot', () => {
    const wrapper = createWrapper(RightAsideItem, {
      slots: {
        content: '<content-slot></content-slot>'
      }
    })

    expect(wrapper.html()).to.include('content-slot')
  })
})
