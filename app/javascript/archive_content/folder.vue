<template lang='pug'>
  .folder.archive-tree-item
    .name.fa.fa-tags 
      | {{ name }}
    .child-documents
      document(
        v-for='document in documents', 
        :document-id='document.id',
        :key="document.key"
      )
    .child-folders
      folder(
        v-for='folder in folders', 
        :folder-id='folder.id',
        :key='folder.id'
      )
</template>

<script>
import Document from './document'
import * as Utils from '../store/json_api/utils'

export default {
  props: [ 'folderId' ],
  name: 'folder',
  components: {
    Document
  },
  computed: {
    folder () {
      return this.$store.getters.entry({ 
        id: this.folderId,
        type: 'folders'
      })
    },
    folders () {
      return this.$store.getters.associatedEntries({ 
        entry: this.folder,
        name: 'folders'
      })
    },
    documents () {
      return this.$store.getters.associatedEntries({
        entry: this.folder,
        name: 'documents'
      })
    },
    name () {
      return Utils.attribute(this.folder, 'name')
    }
  }
}

</script>

<style lang='sass' scoped>
  .name
    font-weight: bold
</style>
