import createWrapper from '../helper'
import DetailsSelectHeaderInput from 'components/details-select-header-input'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('DetailsSelectHeaderInput', () => {
  const factory = ({ propsData = {} } = {}) => {
    return createWrapper(DetailsSelectHeaderInput, {
      stubs: {
        'router-link': true
      },
      propsData: {
        value: { id: '1', type: 'contacts' },
        editMode: false,
        options: [
          { id: '1', type: 'contacts' },
          { id: '2', type: 'contacts' }
        ],
        getOptionLabel: () => 'test text',
        text: 'Title',
        link: '/issues/1',
        ...propsData
      }
    })
  }

  it('show value on non edit mode', () => {
    const wrapper = factory()

    expect(wrapper.html()).not.to.include('test text')
    expect(wrapper.html()).to.include('Title')
    expect(wrapper.find('router-link-stub').props().to).to.eq('/issues/1')
  })

  it('show value on edit mode', () => {
    const wrapper = factory({ propsData: { editMode: true } })

    expect(wrapper.html()).to.include('test text')
    expect(wrapper.html()).not.to.include('Title')
  })
})
