<template lang='pug'>
  .page.category-item 
    a(:href='link')
      .fa.fa-file-text-o 
        | {{this.title }}
</template>

<script>
import * as Utils from '../store/json_api/utils'

export default {
  props: ['pageId'],
  computed: {
    page () {
      return this.$store.getters.entry({ 
        id: this.pageId,
        type: "wiki-pages"
      })
    },
    title () {
      return Utils.attribute(this.page, 'title')
    },
    link () {
      return `/administration/wiki/pages/${this.pageId}`
    }
  }
}

</script>

<style lang='sass' scoped>
 a
   color: black
</style>
