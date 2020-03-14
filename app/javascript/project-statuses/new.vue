<template lang='pug'>
  b-form(@submit="submit")
    b-form-group(
      id="input-group-name",
      label="Name",
      label-for="input-name"
    )
      b-form-input(
        id="input-name",
        v-model="form.attributes.name",
        :state="errorStatus('attributes/name')",
        type="text"
      )
      b-form-invalid-feedback(
        v-for="error in findErrors('attributes/name')",
        :state="errorStatus('attributes/name')"
      )
        | {{ error.detail }}
    b-button(type="submit", variant="success") Create project status
</template>

<script>

export default {
  data () {
    return {
      form: {
        attributes: {
          name: null
        }
      },
      errors: []
    }
  },
  methods: {
    submit (event) {
      event.preventDefault()

      this.$store.dispatch('createProjectStatus', this.form).then(response => {
        this.$router.push(`/administration/project_statuses/${response.data.data.id}`)
      }).catch(({ status, data }) => {
        this.errors = data.errors
      })
    },
    errorStatus (pointer) {
      let errors = this.findErrors(pointer)
      return errors.length == 0 ? null: false
    },
    findErrors (pointer) {
      return this.errors.filter(error => {
        return error.source.pointer.includes(pointer)
      })
      .filter((error, index, self) => {
        return self.findIndex(value => value.detail == error.detail) === index;
      })
    },
  }
}
</script>
