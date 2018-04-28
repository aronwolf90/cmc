import { shallow, createLocalVue } from '@vue/test-utils'
import MarkdownViewer from '../../app/javascript/markdown_viewer'

const localVue = createLocalVue()

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('MarkdownViewer', () => {
  subject(() => shallow(MarkdownViewer, { localVue, propsData: { value: $value } }))

  describe('with the value param', () => {
    def('value', () => 'test')

    it("has currentIssue's title", () => {
      expect($subject.html()).to.contain('test')
    })
  })
})
