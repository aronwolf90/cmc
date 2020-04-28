<template lang='pug'>
  b-form(@submit.prevent="$emit('submit')")
    form-text-input(
      id="input-name",
      v-model="value.attributes.name",
      label="Name",
      :errors="errors",
      error-path="attributes/name"
    )
    form-select(
      id="input-project",
      v-model="value.relationships.project.data",
      label="Project",
      :errors="errors",
      :options="projects",
      error-path="relationships/project",
      v-if="!isGlobalBoard"
    )
    slot
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import FormTextInput from 'components/form-inputs/text'
import FormSelect from 'components/form-inputs/select'

export default {
  props: ['errors', 'value', 'projectRefs'],
  components: {
    FormTextInput,
    FormSelect
  },
  computed: {
    projects () {
      return this.projectRefs.map(ref => {
        const boardList = this.$store.getters.entry(ref)
        return {
          value: ref,
          text: Utils.attribute(boardList, 'name')
        }
      })
    },
    context () {
      return this.$store.getters.context
    },
    isGlobalBoard () {
      return Utils.attribute(this.context, 'global-board')
    }
  },
  watch: {
    value (value) {
      this.$emit('input', value)
    }
  }
}
</script>
