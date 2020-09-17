<template lang='pug'>
  board-item
    template(v-slot:text="")
      router-link(:to="showPath")
        | {{ name }}
    template(v-slot:main-action="")
      issues-record-section(:issue-id="issueId")
    template(v-slot:extra-information="")
      template(v-for="label in labels")
        b-badge(
          v-bind:style="{ 'background-color': label.attributes.color }"
        ) {{ label.attributes.name }}
        |&nbsp;
</template>

<script>

import { Utils } from 'vuex-jsonapi-client'
import BoardItem from '../components/boards/items'
import IssuesRecordSection from '../components/issues_record_section'

export default {
  props: { 'issue-id': { required: true }, 'board-list-id': { required: true } },
  components: {
    IssuesRecordSection,
    BoardItem
  },
  computed: {
    issue () {
      return this.$store.getters.entry({type: 'issues', id: this.issueId})
    },
    name () {
      return Utils.attribute(this.issue, 'title')
    },
    showPath () {
      return `issues/${this.issueId}`
    },
    labels () {
      return this.$store.getters.relationship({
        entry: this.issue,
        name: 'labels'
      }) || []
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
