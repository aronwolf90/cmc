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
          this.$emit('valueChange', this.editor.getValue())
        }
      }
    })
  },
  methods: {
    clear () {
      this.editor.setMarkdown('')
    }
  }
}
</script>
