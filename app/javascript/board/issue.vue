<template lang='pug'>
  .card.issue
    .card-body.issue-body.row
      .col-10.text
        a(v-bind:href="show_path")
          | {{ issue.attributes.title }}
      .col-2
        issues_record_section
</template>

<script>

import IssuesRecordSection from '../components/issues_record_section'

export default {
  props: ['issue_id', 'board_list_id'],
  components: {
    'issues_record_section': IssuesRecordSection
  },
  computed: {
    issue() {
      return this.$store.getters.get({type: 'issues', id: this.issue_id})
    },
    show_path() {
      return `/administration/board_lists/${this.board_list_id}/issues/${this.issue_id}`
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
