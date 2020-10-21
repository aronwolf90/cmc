<template lang='pug'>
  .show(v-if='issue')
    .row
      .col-sm-10
        h4 {{ title }}
      .col-sm-2
        .btn-group.float-right
          b-button(variant='outline-dark', size='sm', :to='`${issueId}/edit`')
            .fa.fa-edit
          .btn.btn-sm.btn-outline-danger(v-on:click='deleteIssue($event)')
            .fa.fa-trash
    .body
      markdown-viewer(:value='description')
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import MarkdownViewer from '../markdown_viewer'

export default {
  props: ['issueId'],
  components: {
    'markdown-viewer': MarkdownViewer
  },
  mounted () {
    this.$store.dispatch('initIssue', this.issueId)
  },
  computed: {
    issue () {
      return this.$store.getters.entry({ type: 'issues', id: this.issueId })
    },
    title () {
      return Utils.attribute(this.issue, 'title')
    },
    description () {
      return Utils.attribute(this.issue, 'description')
    }
  },
  methods: {
    deleteIssue (event) {
      this.$store.dispatch('destroy', {
        entry: this.issue
      }).then(() => {
        this.$router.push('/administration/board_lists')
      })
    }
  }
}
</script>

<style lang='sass' scoped>
</style>
