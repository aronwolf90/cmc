<template lang='pug'>
  b-form-group(
    :id="`input-group-${id}`",
    :label="label",
    :label-for="id"
  )
    v-select(
      :id="id",
      multiple="",
      :value="value",
      :options="options",
      :getOptionLabel="getLabel",
      @input="input"
    )
    b-form-invalid-feedback(
      v-for="error in findErrors(errorPath)",
      :state="errorStatus(errorPath)"
    )
      | {{ error.detail }}
</template>

<script>

export default {
  props: ['id', 'label', 'errors', 'error-path', 'value', 'getLabel', 'options'],
  methods: {
    input (value) {
      this.$emit('input', value)
    },
    errorStatus (pointer) {
      let errors = this.findErrors(pointer)
      return errors.length === 0 ? null : false
    },
    findErrors (pointer) {
      return this.errors.filter(error => {
        return error.source.pointer.includes(pointer)
      })
        .filter((error, index, self) => {
          return self.findIndex(value => value.detail === error.detail) === index
        })
    }
  }
}
</script>
