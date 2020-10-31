<template lang='pug'>
  .index-search-section
    b-form-input(
      type='text',
      v-model='searchText',
      placeholder='Search',
      @focus.native="focused = true",
      autocomplete="off"
    )
    .items(v-if="focused")
      search-select-item(
        v-for="entry in items",
        :title="itemTextFunction(entry)",
        :link="`/administration/${resource}/${entry.id}`",
        :key="entry.id"
      )
</template>

<script>
import SearchSelectItem from 'components/search-select-item'
import IndexSearchSectionItem from './index-search-section-item'

export default {
  components: {
    SearchSelectItem,
    IndexSearchSectionItem
  },
  data () {
    return {
      searchText: '',
      focused: false
    }
  },
  props: [
    'resource',
    'basePath',
    'attribute',
    'itemTextFunction'
  ],
  computed: {
    items () {
      return (this.result && this.result.data) || []
    }
  },
  asyncComputed: {
    result: {
      get () {
        if (!this.searchText) return
        return this.$store.dispatch('get', {
          endpoint: '/api/v1',
          resource: `${this.resource}?query=${this.searchText}`
        })
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
