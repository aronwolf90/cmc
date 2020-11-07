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
      b-button-group.pull-right
        form-btn-destroy(
          @destroy="destroy",
          :entry-ref="document"
        )
        b-button(to='/administration/archive') Cancel
</template>

<script>
import DocumentForm from './form'
import FormBtnDestroy from 'components/form-btn-destroy'
import { Utils } from 'vuex-jsonapi-client'

export default {
  components: {
    DocumentForm,
    FormBtnDestroy
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
        this.$router.push('/administration/archive')
      })
        .catch(({ status, data }) => {
          this.errors = data.errors
        })
    },
    destroy () {
      return this.$store.dispatch('destroy', this.document).then(result => {
        this.$router.push('/administration/archive')
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
