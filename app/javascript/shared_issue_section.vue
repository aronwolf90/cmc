<template lang='pug'>
  #shared-issue-section
    current-record
    current-issue
    issues-search-section

</template>

<script>
import CurrentRecord from 'shared_issue_section/current_record'
import CurrentIssue from 'shared_issue_section/current_issue'
import IssuesSearchSection from 'shared_issue_section/issues_search_section'

export default {
  mounted () {
    this.$store.dispatch('initIssues')
  },
  components: {
    'current-record': CurrentRecord,
    'current-issue': CurrentIssue,
    'issues-search-section': IssuesSearchSection
  }
}
</script>

<style lang='sass' scoped>
#shared-issue-section
  border-top: 1px solid #e7e7e7
  position: relative
</style>
