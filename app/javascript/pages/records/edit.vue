<template lang='pug'>
  records-form(
    @submit="updateRecord",
    submit-text="Update record"
  )
</template>

<script>
import RecordsForm from 'components/records/form'

export default {
  components: {
    RecordsForm
  },
  async beforeRouteEnter (to, _from, next) {
    window.store.dispatch('recordsForm/initializeEditForm', to.params.id)
    next()
  },
  methods: {
    async updateRecord () {
      if (await this.$store.dispatch('recordsForm/update')) {
        this.$router.push('/administration/records')
      }
    }
  }
}
</script>
