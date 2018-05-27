<template lang='pug'>
  .category.category-item
    .title.fa.fa-tags 
      | {{ title }}
    .child-pages
      page(
        v-for='page in pages', 
        :page-id='page.id',
        :key="page.key"
      )
    .child-categories
      category(
        v-for='category in categories', 
        :category-id='category.id',
        :key='category.id'
      )
</template>

<script>
import Page from './page'
import * as Utils from '../store/json_api/utils'

export default {
  props: [ 'categoryId' ],
  name: 'category',
  components: {
    Page
  },
  computed: {
    category () {
      return this.$store.getters.entry({ 
        id: this.categoryId,
        type: 'wiki-categories'
      })
    },
    categories () {
      return this.$store.getters.associatedEntries({ 
        entry: this.category,
        name: 'wiki-categories'
      })
    },
    pages () {
      return this.$store.getters.associatedEntries({
        entry: this.category,
        name: 'wiki-pages'
      })
    },
    title () {
      console.log(this.category)
      return Utils.attribute(this.category, 'title')
    }
  }
}

</script>

<style lang='sass' scoped>
  .title
    font-weight: bold
</style>
