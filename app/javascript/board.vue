<template lang='pug'>
  .issues_board
    .issues_board-header
      .row
        .col-md-10
          b-form-input(type="text", placeholder="Search", size="sm")
        .col-md-2
          span(v-on:click="visitAdd($event)")
            b-button.pull-right(variant="outline-secondary", size="sm", href="`${add_link}`")
              .fa.fa-plus
              |&nbsp add list

    .row.issues_board-row
      draggable.body.issues_board-body(v-model="board_lists")
        template(v-for="board_list in board_lists")
          list(:list_id="board_list.id")

</template>

<script>
import draggable from 'vuedraggable'
import list from 'board/list'

export default {
  components: {
      draggable,
      'list': list
  },
  computed: {
    board_lists: {
      get() {
        this.$store.dispatch('initBoardsLists')
        return this.$store.state.board_lists
      },
      set(value) {
        this.$store.dispatch('updateBoardLists', value)
      }
    },
    add_link() {
      return '/administration/board_lists/new'
    }
  },
  methods: {
    getIssue(id) {
      for (let entry of this.$store.state.issues) {
        if (entry.id == id) return entry
      }
    },
    visitAdd(event) {
      Turbolinks.visit(this.add_link)
      event.preventDefault()
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
</style>
