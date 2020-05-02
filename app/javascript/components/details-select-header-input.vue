<template lang='pug'>
  b-form.details-string-input(
    @submit.prevent="submit",
    :id="id"
  )
    b-input-group(v-if="internEditMode")
      b-form-select(
        v-model="value",
        :id="`${id}-input`",
        :options="options"
      )
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
      router-link(:to="link").font-weight-bold.text-dark {{ text }}
      .clearfix
</template>

<script>

export default {
  props: {
    value: String,
    editMode: Boolean,
    id: String,
    options: Array,
    text: String,
    link: String
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
