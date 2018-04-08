<template lang='pug'>
  #shared-issue-section
    .container-fluid
      .row.current-record(v-if='currentRecord')
        .col-2
        .col-8
          | {{ time }}
        .col-2
          issue-record-section(v-if='issue', :issue_id='issue.id')
    .current-issue(v-if='issue')
      a(v-bind:href='showPath')
        | {{ issue.attributes.title }}
    .relevant-issues.container-fluid
      issue(v-for='relevantIssue in relevantIssues', :issue-id='relevantIssue.id')
    input.search-section(type='text', placeholder='\uf002', v-model='search_text')

</template>

<script>
import IssueRecordSection from 'components/issues_record_section'
import Issue from 'shared_issue_section/issue'

export default {
  data: () => ({ search_text: '', time: '00:00:00' }),
  mounted () {
    this.$store.dispatch('initBoardsLists')
    this.$store.dispatch('initCurrentRecord')

    setInterval(() => {
      this.time = this.consumedTime()
    }, 1000)
  },
  components: {
    'issue-record-section': IssueRecordSection,
    'issue': Issue
  },
  computed: {
    issue () {
      return this.$store.getters.associatedEntry({
        entry: this.currentRecord,
        name: 'issue'
      })
    },
    showPath () {
      if (!this.issue) return
      let boardListsId = this.issue.relationships['board-list'].data.id
      return `/administration/board_lists/${boardListsId}/issues/${this.issue.id}`
    },
    currentRecord () {
      return this.$store.getters.currentRecord
    },
    relevantIssues () {
      let relevantIssues = this.$store.getters.relevantIssues(this.search_text)
      let currentIssueIndex = relevantIssues.findIndex(entry => {
        if (!this.issue) return false
        return entry.id === this.issue.id
      })
      if (currentIssueIndex >= 0) relevantIssues.splice(currentIssueIndex, 1)
      return relevantIssues
    }
  },
  methods: {
    consumedTime () {
      if (!this.currentRecord) return '00:00:00'

      let startTime = (new Date(this.currentRecord.attributes['start-time'])).getTime()
      let currentTime = new Date().getTime()
      let interval = (currentTime - startTime) / 1000
      let hours = Math.floor(interval / 3600).toString()
      let minutes = Math.floor(interval / 60 - hours * 60).toString()
      let seconds = Math.floor(interval - minutes * 60 - hours * 3600).toString()
      return `${hours.padStart(2, '0')}:${minutes.padStart(2, '0')}:${seconds.padStart(2, '0')}`
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
