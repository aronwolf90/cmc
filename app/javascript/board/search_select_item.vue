<template lang='pug'>
.item 
  a(:href="link") {{ title }}
</template>

<script>
import * as Utils from '../store/json_api/utils'
 
export default {
  props: ['issueId'],
  computed: {
    issue () {
      return this.$store.getters.entry({
        id: this.issueId, 
        type: 'issues'
      })
    },
    title () {
      return Utils.attribute(this.issue, 'title')
    },
    boardListId () {
      return Utils.relationship(this.issue, 'board-list').id
    },
    link () {
      return `/administration/board_lists/${this.boardListId}/issues/${this.issue.id}`
    }
  }
}
</script>

<style lang='sass' scoped>
a
  color: black
</style>
