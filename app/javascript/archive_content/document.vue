<template lang='pug'>
  .document.archive-tree-item 
    a(:href='link', target="_blank")
      .fa.fa-file-text-o 
        | {{ name }}&nbsp;&nbsp;
    a.edit-btn(:href='editLink')
      .fa.fa-edit
</template>

<script>
import * as Utils from '../store/json_api/utils'

export default {
  props: ['documentId'],
  computed: {
    document () {
      return this.$store.getters.entry({ 
        id: this.documentId,
        type: "documents"
      })
    },
    name () {
      return Utils.attribute(this.document, 'name')
    },
    link () {
      return `/administration/archive/documents/${this.document.id}`
    },
    editLink () {
      return this.link + '/edit'
    }
  }
}

</script>

<style lang='sass' scoped>
.document
  a
    color: black
  .edit-btn
    font-size: 12px

</style>
