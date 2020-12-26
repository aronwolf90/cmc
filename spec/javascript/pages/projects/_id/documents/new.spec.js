import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import ProjectsDocumentsNew from 'pages/projects/_id/documents/new'
import BootstrapVue from 'bootstrap-vue'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

describe('ProjectsDocumentsNew', () => {
  const folder = {
    id: 1,
    type: 'folders',
    attributes: {
      name: 'Test'
    }
  }

  it('calls createDocument when submit is clicked', (done) => {
    const wrapper = mount(ProjectsDocumentsNew, {
      router,
      store: new Vuex.Store({
        actions: {
          getProjectFolder () {
            return Promise.resolve(folder)
          },
          createDocument (_, payload) {
            expect(payload).to.eql({
              attributes: {
                name: null
              },
              relationships: {
                folder: {
                  data: {
                    id: 1,
                    type: 'folders'
                  }
                }
              }
            })
            done()
            return Promise.resolve({ data: folder })
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          wrapper.find('[type="submit"]').trigger('click')
        })
      })
    })
  })
})
