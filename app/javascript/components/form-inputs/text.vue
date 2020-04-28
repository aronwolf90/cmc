<template lang='pug'>
  b-form-group(
    :id="`input-group-${id}`",
    :label="label",
    :label-for="id"
  )
    b-form-input(
      id="input-name",
      :value="value",
      :state="errorStatus(errorPath)",
      type="text",
      @input="input"
    )
    b-form-invalid-feedback(
      v-for="error in findErrors(errorPath)",
      :state="errorStatus(errorPath)"
    )
      | {{ error.detail }}
</template>

<script>
import LeftAsideItem from 'components/left-aside-item'

export default {
  props: ['id', 'label', 'errors', 'error-path', 'value'],
  methods: {
    input (value) {
      this.$emit('input', value)
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
    }
  }
}
</script>
