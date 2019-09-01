<template lang='pug'>
  .documents-edit
    document-form(
      @onSubmit="onSubmit",
      v-if="result",
      :name="name",
      :folder-type="folderType",
      :folder-id="folderId",
      :errors="errors"
    )
      b-button(type="submit", variant="success") Update document
      a.btn.btn-secondary.pull-right(href='/administration/archive') Cancel
</template>

<script>
import DocumentForm from './form'
import { Utils } from 'vuex-jsonapi-client'

export default {
  components: {
    DocumentForm
  },
  props: [
    'documentId'
  ],
  data () {
    return {
      errors: []
    }
  },
  methods: {
    onSubmit (payload) {
      this.$store.dispatch('updateDocument', {
        entry: this.document,
        payload
      }).then(() => {
        location.replace(`/administration/archive`)
      })
      .catch(({ status, data }) => {
        this.errors = data.errors
      })
    }
  },
  computed: {
    document () {
      if (!this.result) return
      return this.$store.getters.entry({
        type: this.result.data.type,
        id: this.result.data.id
      })
    },
    name () {
      return Utils.attribute(this.document, 'name')
    },
    folderType () {
      if (!this.document) return
      return this.document.relationships.folder.data.type
    },
    folderId () {
      if (!this.document) return
      return this.document.relationships.folder.data.id
    }
  },
  asyncComputed: {
    result () {
      return this.$store.dispatch('getDocument', this.documentId)
    }
  }
}
</script>
