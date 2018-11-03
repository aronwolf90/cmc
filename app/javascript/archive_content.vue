<template lang='pug'>
  #archive-content
    folder(
      v-for='folder in folders', 
      :folder-id='folder.id',
      :key='folder.id'
    )

</template>

<script>
import Folder from 'archive_content/folder'
import { Utils } from 'vuex-jsonapi-client'

export default {
  components: {
    Folder
  },
  created () {
    this.$store.dispatch('initFolders')
  },
  computed: {
    folders() {
      let rootFolders = this.$store.getters
        .metaCollection('folders') || []
      return rootFolders.filter(folder => {
          return Utils.attribute(folder, 'root')
        })
    }
  }
}
</script>

<style lang='sass'>
#archive-content
  .archive-tree-item
    padding-left: 32px
    position: relative
    &:before 
      content: ""
      position: absolute
      border-top: 1px solid #000 
      top: 11px
      width: 8px    
      height: 0
      left: 12px
    &:after
      content: ""
      position: absolute
      left: 12px
      border-left: 1px solid #000
      height: 100%
      top: 3px
    &:last-child::after 
      height: 8px

</style>
