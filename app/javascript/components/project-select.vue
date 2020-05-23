<template lang='pug'>
  search-select(
    :label="label",
    @input="input",
    @search="fetchOptions",
    :value="(value || {}).id",
    :options="options",
    id="project-select"
  )
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import SearchSelect from 'components/form-inputs/search-select'

export default {
  components: {
    SearchSelect
  },
  props: {
    value: {
      type: Object,
      default: null
    },
    label: {
      type: String,
      default: ''
    }
  },
  computed: {
    options () {
      return (((this.$store || {}).getters || {}).projects || []).map(project => {
        return {
          value: project.id,
          text: Utils.attribute(project, 'name')
        }
      })
    }
  },
  methods: {
    input (value) {
      this.$emit('input', { id: value, type: 'projects' })
    },
    fetchOptions (search, loading) {
      loading(true)
      this.$store.dispatch('searchProject', search).then(() => {
        loading(false)
      })
    }
  }
}
</script>
