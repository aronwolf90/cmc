<template lang='pug'>
  .document.archive-tree-item 
    a(:href='link', target="_blank")
      .fa.fa-file-text-o 
        | {{ name }}
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
    }
  }
}

</script>

<style lang='sass' scoped>
 a
   color: black
</style>
