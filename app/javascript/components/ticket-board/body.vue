<template lang='pug'>
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
import { Utils } from 'vuex-jsonapi-client'
import { mapGetters, mapMutations } from 'vuex'
 
export default {
  components: {
    Draggable,
    List,
    ProjectSelect,
    SearchSelect
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
  }
}
</script>

<style lang='sass' scoped>
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
