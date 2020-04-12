<template lang='pug'>
  div
    label.font-weight-bold {{ label }}
    basic-select(
      :options="options",
      :selected-option="item",
      placeholder="select item",
      @select="select"
    )
    hr.divider
</template>

<script>
import { BasicSelect } from 'vue-search-select'

export default {
  props: ['item', 'options', 'label'],
  data () {
    return { searchText: '' }
  },
  methods: {
    select (item) { this.$emit('select', item) }
  },
  components: {
    BasicSelect
  }
}
</script>

<style lang='sass' scoped>
label
  margin-top: 8px
  margin-left: 18px
  margin-bottom: 0
  color: grey
.divider
  margin-top: 0
  margin-bottom: 0
</style>

<style lang='sass'>
.dropdown
  background-color: #f8f8f8 !important
  border: none !important
  color: grey !important
</style>
