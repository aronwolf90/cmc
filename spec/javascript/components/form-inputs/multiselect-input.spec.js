import createWrapper from '../../helper'
import MultiselectInput from '../../../../app/javascript/components/form-inputs/multiselect'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('MultiselectInput', () => {
  afterEach(() => {
    sandbox.restore()
  })

  const factory = (propsData) => {
    return createWrapper(MultiselectInput, { propsData })
  }

  it('renders options, when they are selected', async () => {
    const propsData = {
      options: [{ id: '1', type: 'labels' }],
      value: [{ id: '1', type: 'labels' }],
      errors: [],
      getColor () { return 'yellow' },
      getLabel () { return 'test' }
    }
    const wrapper = factory(propsData)

    expect(wrapper.html()).to.include('yellow')
    expect(wrapper.html()).to.include('test')
  })

  it('does not render options, when none is selected', async () => {
    const propsData = {
      options: [{ id: '1', type: 'labels' }],
      value: [],
      errors: [],
      getColor () { return 'yellow' },
      getLabel () { return 'test' }
    }
    const wrapper = factory(propsData)

    expect(wrapper.html()).not.to.include('yellow')
    expect(wrapper.html()).not.to.include('test')
  })

  it('render errors, when they are present', async () => {
    const propsData = {
      options: [{ id: '1', type: 'labels' }],
      value: [],
      errors: [{ source: { pointer: 'this' }, detail: 'error text' }],
      getColor () { return 'yellow' },
      getLabel () { return 'test' }
    }
    const wrapper = factory(propsData)

    expect(wrapper.html()).not.to.include('error text')
  })

  it('does not render errors, when they are not present', async () => {
    const propsData = {
      options: [{ id: '1', type: 'labels' }],
      value: [],
      errors: [],
      getColor () { return 'yellow' },
      getLabel () { return 'test' }
    }
    const wrapper = factory(propsData)

    expect(wrapper.html()).not.to.include('error text')
  })
})
