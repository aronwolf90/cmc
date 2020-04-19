<template lang='pug'>
  .tickets
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
