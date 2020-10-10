import createWrapper from '../helper'
import SearchSelectItem from 'components/search-select-item'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('SearchSelectItem', () => {
  afterEach(() => sandbox.restore())

  it('render it correctly', () => {
    const wrapper = createWrapper(SearchSelectItem, {
      propsData: {
        title: 'Test title',
        link: '/test-link'
      },
      slots: {
        default: '<div>Test slot</div>'
      }
    })

    expect(wrapper.html()).to.include('Test title')
    expect(wrapper.html()).to.include('/test-link')
    expect(wrapper.html()).to.include('<div>Test slot</div>')
  })
})
