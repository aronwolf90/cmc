<template lang='pug'>
  .issues-search-section
    .relevant-issues.container-fluid
      issue(v-for='issue in issues', :key='issue.id', :issue-id='issue.id')
    input.search-section(type='text', placeholder='\uf002', v-model='search_text')

</template>

<script>
import Issue from 'shared_issue_section/issue'
import * as Utils from '../store/json_api/utils'

export default {
  data: () => ({ search_text: '', time: '00:00:00' }),
  created () {
    this.$store.dispatch('initIssues')
    this.$store.dispatch('initCurrentIssue')
  },
  components: {
    'issue': Issue
  },
  computed: {
    currentIssue () {
      return this.$store.getters.currentIssue
    },
    relevantIssues () {
      return this.$store.getters.relevantIssues(this.search_text) || []
    },
    issues () {
      return this.relevantIssues.filter(entry => {
        return !Utils.sameRef(this.currentIssue, entry)
      })
    }
  }
}
</script>

<style lang='sass' scoped>
.issues-search-section
  padding-bottom: 19px
  .relevant-issues
    padding-left: 0 !important
    min-height: 220px
    max-height: 220px
    overflow: auto
    .issue
      margin-left: 0
  .search-section
    width: calc(100% - 2px)
    border-right: 0
    border-left: 0
    border-bottom: 0
    border-top: 0
    font-family: FontAwesome
    &::placeholder
      text-align: center
</style>
