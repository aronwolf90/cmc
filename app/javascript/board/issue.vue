<template lang='pug'>
  .card.issue
    .card-body.issue-body.row
      .col-10.text
        a(v-bind:href='showPath', v-on:click='visitShow($event)')
          | {{ issue.attributes.title }}
      .col-2
        issues_record_section(:issue_id="issueId")
</template>

<script>

import IssuesRecordSection from '../components/issues_record_section'

export default {
  props: { 'issue-id': { required: true }, 'board-list-id': { required: true } },
  components: {
    'issues_record_section': IssuesRecordSection
  },
  computed: {
    issue () {
      return this.$store.getters.entry({type: 'issues', id: this.issueId})
    },
    showPath () {
      return `/administration/board_lists/${this.boardListId}/issues/${this.issueId}`
    }
  },
  methods: {
    visitShow (event) {
      Turbolinks.visit(this.showPath) /* eslint-disable-line no-undef */
      event.preventDefault()
    }
  }
}

</script>

<style lang='sass' scoped>
  .issue
    margin: 5px
    box-shadow: 0 1px 2px rgba(186,186,186,0.5)
    .issue-body
      padding: 0.5rem
      .text
        overflow: hidden
        text-overflow: ellipsis
        a
          color: black
</style>
