<template lang='pug'>
  b-form(@submit="submit")
    b-button(type="submit", variant="success") Create record
</template>

<script>

export default {
  data () {
    return {
      data: {
        attributes: {
        }
      },
      errors: []
    }
  },
  methods: {
    submit (event) {
      event.preventDefault()

      this.$store.dispatch('createRecord', this.data).then(() => {
        location.replace('/administration/rrecords')
      }).catch(({ status, data }) => {
        this.errors = data.errors
      })
    }
  }
}
</script>
