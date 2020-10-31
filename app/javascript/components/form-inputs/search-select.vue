<template lang='pug'>
  span
    b-form-group(
      :id="`input-group-${id}`",
      :label="label",
      v-if="label",
      v-bind:class="{ error: errorStatus == false }"
    )
      v-select(
        @input='input',
        :value='currentValue',
        :options='selectOptions',
        @search="search",
        :id="id",
      )
      b-form-invalid-feedback(
        v-for="(error, index) in selectedErrors",
        :state="errorStatus",
        :key="index"
      )
        | {{ error.detail }}
    template(v-else="")
      v-select(
        @input="input",
        :value="currentValue",
        :options='selectOptions',
        @search="search",
      )
      b-form-invalid-feedback(
        v-for="(error, index) in selectedErrors",
        :state="errorStatus",
        :key="index"
      )
          | {{ error.detail }}
</template>

<script>
import VSelect from 'vue-select'

export default {
  props: {
    value: {
      type: String,
      default: null
    },
    label: {
      type: String,
      default: ''
    },
    options: {
      type: Array,
      default () {
        return []
      }
    },
    id: {
      type: String,
      default: String
    },
    errors: {
      type: Array,
      default () {
        return []
      }
    },
    errorPath: {
      type: String,
      default: ''
    }
  },
  components: {
    VSelect
  },
  computed: {
    currentValue () {
      return this.selectOptions.find(option => {
        return option.code === this.value
      })
    },
    selectOptions () {
      return this.options.map(option => {
        return {
          code: option.value,
          label: option.text
        }
      })
    },
    selectedErrors () {
      return this.errors.filter(error => {
        return error.source.pointer.includes(this.errorPath)
      })
        .filter((error, index, self) => {
          return self.findIndex(value => value.detail === error.detail) === index
        })
    },
    errorStatus () {
      return this.selectedErrors.length === 0 ? null : false
    }
  },
  methods: {
    search (search, loading) {
      this.$emit('search', search, loading)
    },
    input (value) {
      this.$emit('input', value.code)
    }
  }
}
</script>

<style lang='sass'>
  .error
    .vs__dropdown-toggle
      border: 1px solid red
</style>
