<template lang='pug'>
  .card.issue
    .card-body.issue-body.row
      .col-10.text
        router-link(:to='showPath')
          | {{ issue.attributes.title }}
      .col-2
        issues-record-section(:issue-id="issueId")
</template>

<script>

import IssuesRecordSection from '../components/issues_record_section'

export default {
  props: { 'issue-id': { required: true }, 'board-list-id': { required: true } },
  components: {
    'issues-record-section': IssuesRecordSection
  },
  computed: {
    issue () {
      return this.$store.getters.entry({type: 'issues', id: this.issueId})
    },
    showPath () {
      return `/administration/issues/${this.issueId}`
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
