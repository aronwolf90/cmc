import createWrapper from '../../helper'
import BoardIssuesNew from 'board/issues/new'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('board/issues/new.vue', () => {
  let wrapper = null

  afterEach(() => {
    sandbox.restore()
    wrapper.destroy()
  })

  const dispatch = sandbox.stub()
  const options = {
    attachToDocument: true,
    stubs: {
      MarkdownEditor: true,
      MultiselectInput: true,
      textInput: true
    },
    mocks: {
      $store: {
        dispatch: dispatch,
        getters: {
          collection: () => [],
          boardList: () => ({ id: 1, type: 'board-lists' }),
          selectedProject: { id: 1, type: 'projects' }
        }
      }
    }
  }

  dispatch.returns(Promise.resolve())

  it('renders labels input', async () => {
    const entry = {
      id: 1,
      type: 'labels',
      attributes: {
        color: 'FF5733'
      }
    }
    options.mocks.$store.getters.collection = () => [entry]
    options.mocks.$store.getters.entry = () => entry
    wrapper = createWrapper(BoardIssuesNew, options)
    const labelInput = wrapper.find('#input-labels')

    expect(labelInput.props().options)
      .to.eql([{ id: 1, type: 'labels' }])
    expect(labelInput.props().getColor({ id: 1, type: 'labels' }))
      .to.eq('FF5733')
    expect(labelInput.props().value).to.eql([])
    expect(labelInput.props().errors).to.eql([])
  })

  it('calls createIssue when submit is clicked', async () => {
    wrapper = createWrapper(BoardIssuesNew, options)
    wrapper.vm.$router.push('/board_lists/1/issues/new')

    wrapper.find('#input-description').vm.$emit('input', 'description')
    wrapper.find('#input-labels').vm.$emit('input', [{ id: '1', type: 'labels' }])
    wrapper.find('#input-user').vm.$emit('input', [{ id: '1', type: 'users' }])
    wrapper.find('#input-title').vm
      .$emit('input', 'title')
    await wrapper.vm.$nextTick()
    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()

    expect(dispatch).to.have.been.calledWith('createIssue', {
      attributes: {
        title: 'title',
        description: 'description'
      },
      relationships: {
        'board-list': {
          data: { id: 1, type: 'board-lists' }
        },
        project: {
          data: { id: 1, type: 'projects' }
        },
        labels: {
          data: [{ id: '1', type: 'labels' }]
        },
        user: {
          data: [{ id: '1', type: 'users' }]
        }
      }
    })
    expect(wrapper.vm.$route.path).to.eq('/board_lists')
  })

  it('show errors when they are present', async () => {
    dispatch.withArgs('createIssue').returns(
      Promise.reject({
        status: 'fail',
        data: {
          errors: [{ source: { pointer: 'attributes/title' } }]
        }
      })
    )
    wrapper = createWrapper(BoardIssuesNew, options)

    wrapper.find('[type="submit"]').trigger('click')
    await wrapper.vm.$nextTick()
    await wrapper.vm.$nextTick()

    expect(wrapper.vm.errors).to.eql([{ source: { pointer: 'attributes/title' } }])
  })
})
