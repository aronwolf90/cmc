<template lang='pug'>
  .markdown-editor
</template>

<script>
import Editor from 'tui-editor'

export default {
  props: ['value'],
  mounted () {
    Editor.factory({
      el: this.$el,
      viewer: true,
      height: '500px',
      initialValue: this.value
    })
  }
}
</script>
