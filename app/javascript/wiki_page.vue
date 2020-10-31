<template lang='pug'>
  show-container(v-if='wikiPage')
    show-body
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
import ShowContainer from 'components/show-container'
import ShowBody from 'components/show-body'

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
    RightAside,
    ShowContainer,
    ShowBody
  },
  created () {
    this.$store.dispatch('initWikiPage', this.wikiPageId)
    if (!window.location.hash) router.replace('/')
  },
  computed: {
    wikiPage () {
      return this.$store.getters.entry({ type: 'wiki-pages', id: this.wikiPageId })
    }
  }
}
</script>

<style lang='sass' scoped>
</style>
