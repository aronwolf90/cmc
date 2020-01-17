<template lang='pug'>
  b-form(@submit="submit")
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
    b-button(type="submit", variant="success") Update configuration
    b-button.pull-right(variant="destroy", @click="destroy") Destroy
</template>

<script>

export default {
  props: ['userId'],
  data () {
    return {
      data: {
        attributes: {
          type: null
        }
      }
    }
  },
  created () {
    this.$store.dispatch('getUser', this.userId).then(response => {
      this.data.attributes.type = response.data.attributes.type
    })
  },
  computed: {
    user () {
      return this.$store.getters.getUser(this.userId)
    }
  },
  methods: {
    submit (event) {
      event.preventDefault()
 
      this.$store.dispatch('updateUserConfiguration', { user: this.user, payload: this.data }).then(() => {
        location.reload()
      })
    },
    destroy (event) {
      this.$store.dispatch('destroyUser', this.user).then(() => {
        location.replace('/administration/users')
      })
    }
  }
}
</script>
