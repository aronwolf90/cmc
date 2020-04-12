<template lang='pug'>
  .show(v-if='wikiPage')
    .row
      .col-sm-10
        h4 {{ title }}
      .col-sm-2
        .btn-group.float-right
          b-button(variant='outline-dark', size='sm', to='/edit')
            .fa.fa-edit
          .btn.btn-sm.btn-outline-danger(v-on:click='deleteWikiPage($event)')
            .fa.fa-trash
    .body
      markdown-viewer(:value='content')
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import MarkdownViewer from '../markdown_viewer'

export default {
  props: ['wikiPageId'],
  components: {
    'markdown-viewer': MarkdownViewer
  },
  mounted () {
    this.$store.dispatch('initWikiPage', this.wikiPageId)
  },
  computed: {
    wikiPage () {
      return this.$store.getters.entry({type: 'wiki-pages', id: this.wikiPageId})
    },
    title () {
      return Utils.attribute(this.wikiPage, 'title')
    },
    content () {
      return Utils.attribute(this.wikiPage, 'content')
    }
  },
  methods: {
    deleteWikiPage (event) {
      this.$store.dispatch('destroy', {
        entry: this.wikiPage
      }).then(() => {
        location.replace('/administration/wiki')
      })
    }
  }
}
</script>

<style lang='sass' scoped>
</style>
