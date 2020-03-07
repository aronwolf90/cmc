<template lang='pug'>
  .markdown-editor
</template>

<script>
import Editor from 'tui-editor'

export default {
  props: ['value'],
  data () {
    return { editor: null }
  },
  mounted () {
    this.editor = new Editor({
      el: this.$el,
      initialEditType: 'markdown',
      previewStyle: 'tab',
      height: '300px',
      initialValue: this.value,
      events: {
        change: (event) => {
          this.$emit('input', this.editor.getValue())
          this.$emit('valueChange', this.editor.getValue())
        }
      }
    })
    this.$el.editor = this // hack to allow integration tests
  },
  methods: {
    clear () {
      this.editor.setMarkdown('')
    },
    setValue (text) { // hack to allow integration tests
      this.editor.setMarkdown(text)
      this.$emit('valueChange', this.editor.getValue())
    }
  }
}
</script>
