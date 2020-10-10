<template lang='pug'>
  .search-select
    b-form-input(
      type='text',
      v-model='searchText',
      placeholder='Search',
      @focus.native="focused = true",
      autocomplete="off"
    )
    .items(v-if="focused")
      slot(
        v-for="item in items",
        v-bind:item=item",
        :key="item.id"
      )
</template>

<script>
import SearchSelectItem from './search-select-item'

export default {
  data () {
    return {
      searchText: '',
      focused: false,
      requestItems: null
    }
  },
  components: {
    SearchSelectItem
  },
  mounted () {
    window.onclick = () => {
      this.focused = false
    }
    this.$el.onclick = (event) => {
      event.stopPropagation()
    }
  },
  asyncComputed: {
    items: {
      get () {
        this.$store.dispatch('get', {
          url: `${this.endpoint}?query=${this.searchText}`
        }).then(response => response.data)
      },
      watch: ['searchText']
    }
  }
}
</script>

<style lang='sass' scoped>
.project-search
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
