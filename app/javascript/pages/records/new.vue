<template lang='pug'>
  records-form(
    @submit="updateRecord",
    submit-text="Create record"
  )
</template>

<script>
import RecordsForm from 'components/records/form'

export default {
  components: {
    RecordsForm
  },
  async beforeRouteEnter (to, _from, next) {
    await window.store.dispatch('recordsForm/initializeNewForm')
    next()
  },
  methods: {
    async updateRecord () {
      if (await this.$store.dispatch('recordsForm/create')) {
        this.$router.push('/administration/records')
      }
    }
  }
}
</script>
