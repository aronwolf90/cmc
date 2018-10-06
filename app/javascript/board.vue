<template lang='pug'>
  .issues-board
    .issues-board-header
      .row
        .col-sm-8
          search-select
        .col-sm-2
          project-select
        .col-sm-2
          a.btn.btn-sm.btn-outline-secondary(v-on:click='visitAdd($event)', :href='addLink')
            .fa.fa-plus
            |&nbsp add list

    draggable.body.issues-board-body(v-model='boardLists')
      list(v-for='boardList in boardLists', :key='boardList.id', :list-id='boardList.id')

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
    this.$store.dispatch('initBoardsLists')
    this.$store.dispatch('initIssues')
  },
  computed: {
    boardLists: {
      get () {
        return this.$store.getters.metaCollection('board_lists') || []
      },
      set (boardLists) {
        this.$store.dispatch('sortBoardLists', boardLists)
      }
    },
    addLink () {
      return '/administration/board_lists/new'
    }
  },
  methods: {
    visitAdd (event) {
      Turbolinks.visit(this.addLink) /* eslint-disable-line no-undef */
      event.preventDefault()
    }
  }
}
</script>

<style lang='sass' scoped>
  .issues-board
    height: calc(100% + 7px)
    .issues-board-header
      padding-bottom: 10px
      margin-right: 7px
      height: 38px
    .issues-board-body
      overflow-x: scroll
      white-space: nowrap
      margin-right: -15px
      margin-left: -15px
      height: calc(100% - 38px)
      padding-left: 13px
</style>
