<template lang='pug'>
  a.issue.row(v-bind:href='showPath')
    .col-10
      | {{ issue.attributes.title }}
    .col-2
      issue-record-section(:issue_id='issue.id')
</template>

<script>
import IssueRecordSection from 'components/issues_record_section'

export default {
  components: {
    'issue-record-section': IssueRecordSection
  },
  props: {
    issueId: {
      type: String,
      required: true
    }
  },
  computed: {
    issue () {
      return this.$store.getters.get({
        type: 'issues',
        id: this.issueId
      })
    },
    showPath () {
      if (!this.issue) return
      let boardListsId = this.issue.relationships['board-list'].data.id
      return `/administration/board_lists/${boardListsId}/issues/${this.issue.id}`
    }
  }
}
</script>

<style lang='sass' scoped>
.issue
  padding-top: 5px
  padding-bottom: 5px
  padding-left: 2px
  border-bottom: 1px solid #e7e7e7
  color: grey
  &:hover
    background-color: #e7e7e7
    text-decoration: none
  .col-2
    padding: 0

</style>
