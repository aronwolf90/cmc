<template lang='pug'>
  b-form(@submit="onSubmit")
    b-form-group(
      id="input-group-firstname",
      label="Firstname",
      label-for="input-firstname"
    )
      b-form-input(
        id="input-firstname",
        v-model="data.attributes.firstname",
        required="",
        type="text"
      )
    b-form-group(
      id="input-group-lastname",
      label="Lastname",
      label-for="input-lastname"
    )
      b-form-input(
        id="input-lastname",
        required="",
        v-model="data.attributes.lastname",
        type="text"
      )
    b-form-group(
      id="input-group-email",
      label="E-Mail",
      label-for="input-email"
    )
      b-form-input(
        id="input-email",
        v-model="data.attributes.email",
        required="",
        type="email"
      )
    b-form-group(
      id="input-group-type",
      label="Type",
      label-for="input-type"
    )
      b-form-select(
        id="input-type",
        required="",
        v-model="data.attributes.type"
      )
        option(value="Admin") Admin
        option(value="Employee") Employee
        option(value="Customer") Customer
    b-button(type="submit", variant="success") Create user
    a.btn.btn-secondary.pull-right(href='/administration/users') Cancel
</template>

<script>

export default {
  data () {
    return {
      data: {
        attributes: {
          firstname: null,
          lastname: null,
          email: null,
          type: null
        }
      }
    }
  },
  methods: {
    onSubmit (event) {
      event.preventDefault()

      this.$store.dispatch('createUser', this.data).then(() => {
        location.replace('/administration/users')
      })
    }
  }
}
</script>
