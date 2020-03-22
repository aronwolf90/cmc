<template lang='pug'>
  draggable.body.projects-board-body(v-model="projectBoardLists")
    list(
      v-for='projectBoardList in projectBoardLists',
      :key='projectBoardList.id',
      :project-board-list-id='projectBoardList.id',
      :id='`column-${projectBoardList.id}`'
    )
</template>

<script>
import Draggable from 'vuedraggable'
import List from './board/list'
import { Utils } from 'vuex-jsonapi-client'
import { mapGetters, mapMutations } from 'vuex'
 
export default {
  components: {
    Draggable,
    List
  },
  computed: {
    projectBoardLists: {
      get () {
        return this.$store.getters['projects-board/projectBoardLists']
      },
      set (projectBoardLists) {
        this.$store.commit('projects-board/projectBoardLists', projectBoardLists)
      }
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
