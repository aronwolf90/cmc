<template lang='pug'>
  #issue(v-if='wikiPage')
    .container-fluid
      router-view(:wiki-page-id='wikiPage.id')
</template>

<script>
import Router from 'vue-router'

import Show from 'wiki_page/show'
import Edit from 'wiki_page/edit'

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

</style>
