<template lang='pug'>
  .issues-search-section
    .relevant-issues.container-fluid
      issue(v-for='relevantIssue in relevantIssues', :key='relevantIssue.id', :issue-id='relevantIssue.id')
    input.search-section(type='text', placeholder='\uf002', v-model='search_text')

</template>

<script>
import Issue from 'shared_issue_section/issue'
import * as Utils from '../store/json_api/utils'

export default {
  data: () => ({ search_text: '', time: '00:00:00' }),
  mounted () {
    this.$store.dispatch('initCurrentIssue')
  },
  components: {
    'issue': Issue
  },
  computed: {
    issue () {
      return this.$store.getters.currentIssue
    },
    relevantIssues () {
      return (this.$store.getters.relevantIssues(this.search_text) || []).filter(entry => {
        return !Utils.sameRef(this.issue, entry)
      })
    }
  }
}
</script>

<style lang='sass' scoped>
.relevant-issues
  padding-left: 0 !important
  height: 250px
  .issue
    margin-left: 0
.search-section
  position: absolute
  bottom: 19px
  width: 100% !important
  border-right: 0
  border-left: 0
  border-bottom: 0
  border-top: 0
  font-family: FontAwesome
  &::placeholder
    text-align: center
</style>
