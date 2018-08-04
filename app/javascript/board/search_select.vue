<template lang='pug'>
  .search
    b-form-input(
      type='text', 
      v-model='searchText', 
      placeholder='Search', 
      size='sm',
      @blur.native="focused = false",
      @focus.native="focused = true"
    )
    .items(v-if="issues.length && focused")
      search-select-item(
        v-for="issue in issues", 
        :issue-id="issue.id",
        :key="issue.id"
      )
</template>

<script>
import SearchSelectItem from './search_select_item'
 
export default {
  data () {
    return { searchText: '', focused: false }
  },
  components: {
    SearchSelectItem
  },
  computed: {
    issues () {
      if (this.searchText === '') return [] 
      return this.$store.getters.relevantIssues(this.searchText) || []
    }
  }
}
</script>

<style lang='sass' scoped>
.search
  position: relative
  .items
    position: absolute
    z-index: 1000
    background: white
    width: 460px
    border: 1px solid lightgrey
    margin-left: 1px
    max-height: 400px
    overflow-y: auto
    box-shadow: 0 1px 7px 0 rgba(0, 0, 0, .3)
    padding: 4px
    a
      color: black
</style>
