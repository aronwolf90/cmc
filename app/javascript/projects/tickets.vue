<template lang='pug'>
  .tickets
    router-link.pull-right.btn.btn-sm.btn-outline-secondary(
      to='board_lists/new'
    )
      .fa.fa-plus
      |&nbsp add list
    .clearfix
    .mb-2
    ticket-board-body
</template>

<script>
import TicketBoardBody from 'components/ticket-board/body'


export default {
  props: ['projectId'],
  components: {
    TicketBoardBody
  },
  beforeRouteEnter (to, from, next) {
    window.store.dispatch('board/fetch', to.params.projectId).then(() => {
      next()
    })
  }
}
</script>
<style lang="sass" scoped>
.tickets
  height: 100%
</style>
