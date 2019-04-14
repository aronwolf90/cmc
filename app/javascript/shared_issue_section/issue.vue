<template lang='pug'>
  a.issue.row(v-bind:href='showPath', v-on:click='visitShow($event)')
    .col-10.text-section
      | {{ issue.attributes.title }}
    .col-2
      issues-record-section(:issue-id='issue.id')
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import IssuesRecordSection from 'components/issues_record_section'

export default {
  components: {
    'issues-record-section': IssuesRecordSection
  },
  props: { issueId: { required: true } },
  created () {
    this.$store.dispatch('initCurrentIssue')
  },
  computed: {
    issue () {
      return this.$store.getters.entry({type: 'issues', id: this.issueId})
    },
    boardListId () {
      return Utils.relationship(this.issue, 'board-list').id
    },
    showPath () {
      return `/administration/issues/${this.issueId}`
    }
  },
  methods: {
    visitShow (event) {
      event.preventDefault()
      Turbolinks.visit(this.showPath) /* eslint-disable-line no-undef */
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
  .text-section
    text-overflow: ellipsis
    overflow: hidden
  .col-2
    padding: 0

</style>
