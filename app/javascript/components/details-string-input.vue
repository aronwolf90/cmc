<template lang='pug'>
  b-form.details-string-input(@submit.prevent="submit")
    b-input-group(v-if="internEditMode")
      b-form-input(v-model="value")
      b-input-group-append
        b-button(
          variant="outline-secondary",
          size="sm",
          type="submit"
        ) 
          .fa.fa-spinner.fa-spin(v-if='isSaving')
          template(v-else='') ok
    span(v-else="")
      b-button.float-right(
        variant="light",
        size="sm",
        @click="internEditMode=true"
      )
          .fa.fa-edit
      .text {{ value }} 
      .clearfix
</template>

<script>

export default {
  props: {
    value: String,
    editMode: Boolean
  },
  data () {
    return {
      internEditMode: false,
      isSaving: false
    }
  },
  methods: {
    submit () {
      this.isSaving = true
      this.$emit('submit')
    }
  },
  watch: {
    value (value) {
      this.$emit('input', value)
    },
    editMode: {
      immediate: true,
      handler (editMode) {
        this.internEditMode = editMode
      }
    },
    internEditMode (editMode) {
      this.$emit('update:editMode', editMode)
      this.isSaving = false
    }
  }
}
</script>

<style lang='sass' scoped>
  .details-string-input
    margin-right: -11px
    .text 
      word-break: break-word;
    input
      padding: 3px
      height: auto
</style>
