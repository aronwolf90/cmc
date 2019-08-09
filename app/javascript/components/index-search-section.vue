<template lang='pug'>
  .index-search-section
    b-form-input(
      type='text', 
      v-model='searchText', 
      placeholder='Search',
      @focus.native="focused = true"
    )
    .items(v-if="focused")
      index-search-section-item(
        v-for="item in items", 
        :item-type="item.type",
        :item-id="item.id",
        :attribute="attribute",
        :base-path="basePath",
        :key="item.id"
      )
</template>

<script>
import IndexSearchSectionItem from './index-search-section-item'

export default {
  components: {
    IndexSearchSectionItem
  },
  data () {
    return { 
      searchText: '', 
      focused: false
    }
  },
  props: [
    "searchEndpoint",
    "basePath",
    "attribute"
  ],
  computed: {
    items () {
      return this.result && this.result.data || []
    }
  },
  asyncComputed: {
    result: {
      get () {
        return this.$store.dispatch(
          'searchContacts',
          this.searchText
        )
      },
      watch: ['searchText']
    }
  },
  mounted () {
    window.onclick = () => {
      this.focused = false
    }
    this.$el.onclick = (event) => {
      event.stopPropagation()
    }
  }
}
</script>

<style lang='sass' scoped>
.index-search-section
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
</style>
