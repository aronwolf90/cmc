import { shallow, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import Comments from '../../../../app/javascript/components/projects/comments'

const localVue = createLocalVue()

localVue.use(Vuex)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('Comments', () => {
  const comment = {
    id: 1,
    type: 'comments',
    attributes: { content: 'comment content' }
  }
  const store = new Vuex.Store(
    {
      state: {},
      getters: {
        projectComment () { return () => comment }
      },
      actions: {
        getProjectComments () {
          return Promise.resolve({ data: [comment] })
        }
      }
    })

  it('contain comment', () => {
    const wrapper = shallow(Comments, { store: store, localVue })

    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        expect(wrapper.html()).to.include('comment content')
      })
    })
  })
})
