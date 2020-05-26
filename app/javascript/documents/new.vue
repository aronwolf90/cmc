<template lang='pug'>
  .documents-new
    document-form(@onSubmit='onSubmit', :errors="errors")
      b-button(type="submit", variant="success") Create document
      a.btn.btn-secondary.pull-right(href='/administration/archive') Cancel
</template>

<script>
import DocumentForm from './form'

export default {
  components: {
    DocumentForm
  },
  data () {
    return {
      errors: []
    }
  },
  methods: {
    onSubmit (payload) {
      this.$store.dispatch('createDocument', payload)
      .then(() => {
        this.$router.push('/administration/archive')
      })
      .catch(({ status, data }) => {
        this.errors = data.errors
      })
    }
  }
}
</script>
