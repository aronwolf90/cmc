<template lang='pug'>
  .archive-folders-new
    archive-folders-form(@submit="createFolder")
      b-button(type="submit", variant="success") Create folder
      b-button.pull-right(variant="secondary", to="/administration/archive") Cancel
</template>

<script>
import ArchiveFoldersForm from 'components/folders/form'
import store from 'store'

export default {
  components: {
    ArchiveFoldersForm
  },
  async beforeRouteEnter (to, _from, next) {
    await store.dispatch('foldersForm/initializeNewForm')
    next()
  },
  methods: {
    async createFolder () {
      if (await this.$store.dispatch('foldersForm/create')) {
        this.$router.push('/administration/archive')
      }
    }
  }
}
</script>
