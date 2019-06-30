<template lang='pug'>
  #issue(v-if='wikiPage')
    .container-fluid
      router-view(:wiki-page-id='wikiPage.id')
    right-aside
      category(:wiki-page-id="wikiPageId")
</template>

<script>
import Router from 'vue-router'

import Show from 'wiki_page/show'
import Edit from 'wiki_page/edit'
import Category from 'wiki_page/category'
import RightAside from 'components/right_aside'

const router = new Router({
  routes: [
    {
      path: '/',
      name: 'Show',
      component: Show
    },
    {
      path: '/edit',
      name: 'Edit',
      component: Edit
    }
  ]
})

export default {
  props: ['wikiPageId'],
  router,
  components: {
    Show,
    Edit,
    Category,
    RightAside
  },
  created () {
    this.$store.dispatch('initWikiPage', this.wikiPageId)
    if (!window.location.hash) router.replace('/')
  },
  computed: {
    wikiPage () {
      return this.$store.getters.entry({type: 'wiki-pages', id: this.wikiPageId})
    }
  }
}
</script>

<style lang='sass' scoped>
#issue
  display: flex
  margin-right: -14px
  margin-top: -35px
  .container-fluid
    padding-top: 15px
    overflow-y: auto
    height: calc(100vh - 40px)
  .right-aside
    background-color: #f8f8f8
    border-left: 2px solid #e7e7e7
    width: 200px
    height: calc(100vh - 40px)
</style>

</style>
