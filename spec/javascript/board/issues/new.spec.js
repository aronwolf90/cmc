import { mount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import New from '../../../../app/javascript/board/issues/new'
import BootstrapVue from 'bootstrap-vue'
import sinon from 'sinon'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
const router = new VueRouter()

localVue.use(Vuex)
localVue.use(BootstrapVue)
localVue.use(VueRouter)

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */
/* eslint-disable prefer-promise-reject-errors */

const sandbox = sinon.createSandbox()

describe('New', () => {
  afterEach(() => sandbox.restore())

  it('calls createIssue when submit is clicked', (done) => {
    let wrapper = mount(New, {
      stubs: {
        MarkdownEditor: '<input type="text" id="input-description">'
      },
      router,
      store: new Vuex.Store({
        modules: {
          board: {
            namespaced: true,
            actions: {
              getBoardLists () { Promise.resolve() }
            }
          }
        },
        getters: {
          boardList () {
            return () => ({ id: 1, type: 'board-lists' })
          },
          selectedProject () {
            return { id: 1, type: 'projects' }
          }
        },
        actions: {
          createIssue (_, { attributes, relationships }) {
            expect(attributes).to.eql({
              title: 'title',
              description: null
            })
            expect(relationships).to.eql({
              project: { data: { id: 1, type: 'projects' } },
              'board-list': { data: { id: 1, type: 'board-lists' } }
            })
            done()
            return Promise.resolve()
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    console.log(wrapper.html())
    wrapper.find('#input-title').element.value = 'title'
    wrapper.find('#input-title').trigger('input')
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        sandbox.stub(window.location, 'replace')
        wrapper.find('[type="submit"]').trigger('click')
      })
    })
  })

  it('calls location.replate when no error is present', (done) => {
    let wrapper = mount(New, {
      stubs: {
        MarkdownEditor: '<input id="input-description"/>'
      },
      router,
      store: new Vuex.Store({
        modules: {
          board: {
            namespaced: true,
            actions: {
              getBoardLists () { Promise.resolve() }
            }
          }
        },
        getters: {
          boardList () {
            return () => ({ id: 1, type: 'board-lists' })
          },
          selectedProject () {
            return { id: 1, type: 'projects' }
          }
        },
        actions: {
          createIssue (_, { attributes }) {
            return Promise.resolve()
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.find('#input-title').element.value = 'title'
    wrapper.find('#input-title').trigger('input')
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.find('[type="submit"]').trigger('click')
        wrapper.vm.$nextTick(() => {
          wrapper.vm.$nextTick(() => {
            // expect(wrapper.vm.$route.path).to.be.eq('/administration/board_lists')
            done()
          })
        })
      })
    })
  })

  it('show errors when they are present', (done) => {
    let wrapper = mount(New, {
      stubs: {
        MarkdownEditor: '<input id="input-description"/>'
      },
      store: new Vuex.Store({
        getters: {
          boardList () {
            return () => ({ id: 1, type: 'board-lists' })
          },
          selectedProject () {
            return { id: 1, type: 'projects' }
          }
        },
        actions: {
          createIssue ({ attributes }) {
            return Promise.reject({
              status: 'fail',
              data: {
                errors: [{ source: { pointer: 'attributes/title' } }]
              }
            })
          }
        }
      }),
      localVue,
      attachToDocument: true
    })
    wrapper.find('[type="submit"]').trigger('click')
    wrapper.vm.$nextTick(() => {
      wrapper.vm.$nextTick(() => {
        wrapper.vm.$nextTick(() => {
          expect(wrapper.vm.errors).to.eql([{ source: { pointer: 'attributes/title' } }])
          done()
        })
      })
    })
  })
})
