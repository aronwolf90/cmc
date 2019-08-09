<template lang='pug'>
  .contacts-new
    contact-form(@onSubmit='onSubmit')
</template>

<script>
import ContactForm from './form'

export default {
  components: {
    ContactForm
  },
  methods: {
    onSubmit (payload) {
      this.$store.dispatch('createContact', payload).then(() => {
        location.replace('/administration/contacts')
      })
    }
  }
}
</script>
