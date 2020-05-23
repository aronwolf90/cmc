<template lang='pug'>
  span
    b-form-group(
      :id="`input-group-${id}`",
      :label="label",
      v-if="label"
    )
      v-select(
        @input='input',
        :value='currentValue',
        :options='selectOptions',
        @search="search",
        :id="id"
      )
    v-select(
      @input="input",
      :value="currentValue",
      :options='selectOptions',
      @search="search",
      v-else=""
    )
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
      default: []
    },
    id: {
      type: String,
      default: String
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
