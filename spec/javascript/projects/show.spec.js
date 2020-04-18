import createWrapper from '../helper'
import ProjectShow from '../../../app/javascript/projects/show'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('ProjectShow', () => {
  afterEach(() => (sandbox.restore()))

  const project = {
    id: 1,
    type: 'projects',
    attributes: {
      name: 'Test'
    }
  }

  const store = {
    getters: {
      project: () => project
    },
    dispatch: sandbox.stub()
  }

  const factory = () => {
    return createWrapper(ProjectShow, {
      store,
      stubs: {
        comments: true,
        contact: true,
        'main-responsable': true
      }
    })
  }

  it('renders the title', (done) => {
    const wrapper = factory()
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.html()).to.include('Test')
        done()
      })
    })
  })

  it('renders the edit btn', (done) => {
    const wrapper = factory()
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.find('.fa-edit').exists()).to.be.true
        done()
      })
    })
  })

  it('calls destroyProject when fa-trash is clicked', (done) => {
    store.dispatch.returns(Promise.resolve())
    const wrapper = factory()
    wrapper.find('.fa-trash').trigger('click')
    expect(store.dispatch).to.have.been.calledWith('destroyProject')
    done()
  })
})
