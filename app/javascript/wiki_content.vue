<template lang='pug'>
  #wiki-content
    category(
      v-for='category in categories', 
      :category-id='category.id',
      :key='category.id'
    )

</template>

<script>
import Category from 'wiki_content/category'
import * as Utils from './store/json_api/utils'

export default {
  components: {
    Category
  },
  created () {
    this.$store.dispatch('initWikiCategories')
  },
  computed: {
    categories() {
      let rootCategories = this.$store.getters
        .metaCollection('wiki_categories') || []
      return rootCategories.filter(category => {
          return Utils.attribute(category, 'root')
        })
    }
  }
}
</script>

<style lang='sass'>
#wiki-content
  .category-item
    padding-left: 32px
    position: relative
    &:before 
      content: ""
      position: absolute
      border-top: 1px solid #000 
      top: 11px
      width: 8px    
      height: 0
      left: 12px
    &:after
      content: ""
      position: absolute
      left: 12px
      border-left: 1px solid #000
      height: 100%
      top: 3px
    &:last-child::after 
      height: 8px

</style>
