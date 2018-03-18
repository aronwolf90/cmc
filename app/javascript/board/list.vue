<template lang='pug'>
  .card.column
    .card-header
      | {{ board_list.attributes.name }}
      span(v-on:click="visitAdd($event)")
        b-button.pull-right(variant="outline-secondary", size="sm", v-bind:href="`${add_link}`")
          .fa.fa-plus
      b-button.pull-right.text-muted(variant="link", size="sm", @click="destroy()")
        .fa.fa-trash
      .clearfix
    draggable.body(v-model="issues", :options="{group:'issues'}")
      template(v-for="issue in issues")
        issue(:issue_id="issue.id", :board_list_id="board_list.id")

</template>

<script>
import draggable from 'vuedraggable'
import issue from './issue'

export default {
  components: {
      draggable,
      'issue': issue
  },
  props: ['list_id'],
  computed: {
    board_list() {
      return this.$store.getters.get({ type: 'board_lists', id: this.list_id })
    },
    add_link() {
      return `/administration/board_lists/${this.board_list.id}/issues/new`
    },
    issues: {
      get() {
        return this.board_list.relationships.issues.data
      },
      set(issues) {
        this.$store.dispatch('updateBoardListIssues', { board_list: this.board_list, issues: issues })
      }
    }
  },
  methods: {
    getIssue(id) {
      return this.$store.getters.getIssue(id)
    },
    destroy() {
      return this.$store.dispatch('destroy', this.board_list)
    },
    visitAdd(event) {
      Turbolinks.visit(this.add_link)
      event.preventDefault()
    }
  }
}
</script>

<style lang='sass' scoped>
  .column
    display: inline-block
    vertical-align: text-top
    margin-right: 13px
    width: 300px
    .body
      background-color: #fbfbfb
      min-height: 20px
      .issue
        margin: 5px
        box-shadow: 0 1px 2px rgba(186,186,186,0.5)
        .issue-body
          padding: 0.5rem
          .text
            overflow: hidden
            text-overflow: ellipsis
</style>
