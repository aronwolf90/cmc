<template lang='pug'>
  .issues-board
    .issues-board-header
      .row
        .col-sm-6
          search-select
        .col-sm-4
          project-select
        .col-sm-2
          router-link.btn.btn-sm.btn-outline-secondary(
            to='board_lists/new'
          )
            .fa.fa-plus
            |&nbsp add list

    draggable.body.issues-board-body(v-model="boardLists")
      list(
        v-for='boardList in boardLists',
        :key='boardList.id',
        :list-id='boardList.id',
        :id='`column-${boardList.id}`'
      )
</template>

<script>
import Draggable from 'vuedraggable'
import List from 'board/list'
import ProjectSelect from 'board/project_select'
import SearchSelect from 'board/search_select'

export default {
  components: {
    Draggable,
    List,
    ProjectSelect,
    SearchSelect
  },
  created () {
    this.fetch()
  },
  computed: {
    boardLists: {
      get () {
        return this.$store.getters['board/boardLists']
      },
      set (boardLists) {
        this.$store.dispatch('board/sortBoardLists', boardLists)
      }
    }
  },
  methods: {
    fetch () {
      this.$store.dispatch('board/getBoardLists')
    }
  }
}
</script>

<style lang='sass' scoped>
  .issues-board
    display: flex
    flex-flow: column
    height: 100%
    .issues-board-header
      padding-bottom: 10px
      margin-right: 7px
    .issues-board-body
      overflow-x: auto
      overflow-y: auto
      flex-grow : 1
      white-space: nowrap
      margin-right: -15px
      margin-left: -15px
      height: 100%
      padding-left: 13px
</style>
