<template lang='pug'>
  .show(v-if='issue')
    .row
      .col-sm-10
        h4 {{ title }}
      .col-sm-2
        .btn-group.float-right
          b-button(variant='outline-dark', size='sm', to='/edit')
            .fa.fa-edit
          .btn.btn-sm.btn-outline-danger(v-on:click='deleteIssue($event)')
            .fa.fa-trash
    .body
      markdown-viewer(:value='description')
</template>

<script>
import * as Utils from '../store/json_api/utils'
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
      return this.$store.getters.entry({type: 'issues', id: this.issueId})
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
      this.$store.dispatch('delete', { entry: this.issue, endpoint: '/api/v1' })
      Turbolinks.visit('/administration/board') /* eslint-disable-line no-undef */
      event.preventDefault()
    }
  }
}
</script>

<style lang='sass' scoped>
</style>
