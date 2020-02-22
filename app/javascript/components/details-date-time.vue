<template lang='pug'>
  b-form.details-date-time(@submit="submit")
    label(:for="id")
      | {{ label }}
    b-input-group
      datetimepicker(
        :id="id",
        placeholder="01-01-2020 00:00",
        :value="value",
        @input="$emit('input', $event)"
      )
      b-input-group-append
        b-button.fa.fa-spinner.fa-spin(v-if='isSaving')
        b-button(
          type="submit",
          variant="outline-secondary",
          v-else="",
          v-bind:class="{ persisted: isPersisted }"
        ) Ok
    .divider
</template>

<script>
import Datetimepicker from './datetimepicker'

export default {
  components: {
    Datetimepicker
  },
  props: {
    label: String,
    id: [String, Number],
    value: String,
    isSaving: {
      type: Boolean,
      default: false
    },
    isPersisted: {
      type: Boolean,
      default: true
    }
  },
  created () {
    setTimeout(( () => {
      return jqueryFuncs();
    }), 100);
  },
  methods: {
    submit (event) {
      event.preventDefault()
      this.$emit('submit')
    }
  }
}
</script>

<style lang='sass' scoped>
  .details-date-time
    input::placeholder
      color: rgba(191, 191, 191, 0.87)
    input:not(:focus)
      background-color: #f8f8f8
      border: none
      color: grey !important
      &+.input-group-append button.persisted[type="submit"]
        opacity: 0.3
        border: none
        &:hover
          background-color: #f8f8f8 !important
          color: grey !important
    .divider
      margin-top: 0
      margin-bottom: 0
    label
      margin-top: 8px
      margin-left: 18px
      margin-bottom: 0
      color: grey
</style>
