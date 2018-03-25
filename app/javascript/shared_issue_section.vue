<template lang='pug'>
  #shared-issue-section
    .container-fluid
      .row.current-record(v-if="currentRecord")
        .col-2
        .col-8
          | 00:10:00
        .col-2
          issue-record-section(v-if="issue", :issue_id="issue.id")
    .current-issue(v-if="issue")
      a(v-bind:href="showPath")
        | {{ issue.attributes.title }}
    .relevant-issues.container-fluid
      issue(v-for="relevantIssue in relevantIssues", :issue-id="relevantIssue.id")
    input.search-section(type="text", placeholder="\uf002", v-model="search_text")

</template>

<script>
import IssueRecordSection from "components/issues_record_section"
import Issue from "shared_issue_section/issue"

export default {
  created() {
    this.$store.dispatch('initBoardsLists')
  },
  components: {
    "issue-record-section": IssueRecordSection,
    "issue": Issue
  },
  data: () => ({ search_text: "" }),
  computed: {
    issue() {
      return this.$store.getters.getAssociatedEntry({
        entry: this.currentRecord,
        name: 'issue'
      })
    },
    showPath() {
      if (!this.issue) return
      let board_lists_id = this.issue.relationships["board-list"].data.id
      return `/administration/board_lists/${board_lists_id}/issues/${this.issue.id}`
    },
    currentRecord() {
      return this.$store.getters.currentRecord
    },
    relevantIssues() {
      if (!this.$store.getters.getCollection('issues')) return
      let relevantIssues = this.$store.getters.getCollection('issues').slice()
      let currentIssueIndex = relevantIssues.findIndex(entry => {
        if (!this.issue) return false
        return entry.id == this.issue.id
      })
      if (currentIssueIndex >= 0) relevantIssues.splice(currentIssueIndex, 1)
      return relevantIssues.filter(relevantIssue => {
        return relevantIssue.attributes.title.includes(this.search_text)
      })
    }
  }
}
</script>

<style lang='sass' scoped>
#shared-issue-section
  border-top: 1px solid #e7e7e7
  position: relative
  .current-record
    text-align: center
    color: grey
    padding-top: 8px
    .col-2
      padding: 0
  .current-issue
    padding: 10px
    text-align: center
    border-bottom: 1px solid #e7e7e7
    a
      color: grey
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
