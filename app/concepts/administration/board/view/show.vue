<template lang='pug'>
  .issues_board
    .issues_board-header
      .row
        .col-md-10
          b-form-input(type="text", placeholder="Search", size="sm")
        .col-md-2
          b-button.pull-right(variant="outline-secondary", size="sm", href='/administration/board_lists/new')
            .fa.fa-plus
            |&nbsp add list

    .row.issues_board-row
      draggable.body.issues_board-body(v-model="columns")
        .card.column(v-for="column in columns")
          .card-header
            | {{column.attributes.name}}
            b-button.pull-right(variant="outline-secondary", size="sm", v-bind:href="`/administration/issues/new?board_list_id=${column.id}`")
              .fa.fa-plus
            b-button.pull-right.text-muted(variant="link", size="sm")
              .fa.fa-trash
            .clearfix
          draggable.body(v-model="column.relationships.issues.data", :options="{group:'issues'}")
            .card.issue(v-for="issue in column.relationships.issues.data")
              .card-body.issue-body
                | {{issue.attributes.title}}

</template>

<script>
import draggable from 'vuedraggable'

export default {
  components: {
      draggable,
  },
  computed: {
    columns() {
      this.$store.dispatch('initBoardsLists')
      return this.$store.state.columns
    }
  }
}
</script>

<style lang='sass' scoped>
  .issues_board-row
    height: 100%
  .issues_board
    height: 100%
    .issues_board-header
      margin-bottom: 10px
    .issues_board-body
      overflow-x: scroll
      white-space: nowrap
      heigth: 100%
      padding-left: 13px
      .column
        display: inline-block
        vertical-align: text-top
        margin-right: 13px
        width: 300px
        .body
          background-color: #fbfbfb
          .issue
            margin: 5px
            box-shadow: 0 1px 2px rgba(186,186,186,0.5)
            .issue-body
              padding: 0.5rem
</style>
