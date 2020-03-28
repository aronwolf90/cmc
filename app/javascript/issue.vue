<template lang='pug'>
  show-container(v-if='issue')
    show-body
      router-view(:issue-id='id')
      hr.divider
      comments(module="issuesShow")
      br
    right-aside
      assigen(:issue-id='id')
      complexity(:issue-id='id')
      due-at(:issue-id='id')
      deadline-at(:issue-id='id')

</template>

<script>
import RightAside from 'components/right_aside'

import SpentTime from 'issue/spent_time'
import Assigen from 'issue/assigen'
import Complexity from 'issue/complexity'
import Comments from 'components/comments'
import ShowContainer from 'components/show-container'
import ShowBody from 'components/show-body'
import DueAt from 'issue/due-at'
import DeadlineAt from 'issue/deadline-at'

export default {
  props: ['id'],
  components: {
    SpentTime,
    'assigen': Assigen,
    'comments': Comments,
    'complexity': Complexity,
    RightAside,
    ShowContainer,
    ShowBody,
    DueAt,
    DeadlineAt
  },
  created () {
    this.$store.dispatch('initIssue', this.id)
    this.$store.dispatch('issuesShow/fetch', this.id)
  },
  computed: {
    issue () {
      return this.$store.getters.entry({type: 'issues', id: this.id})
    }
  }
}
</script>

<style lang='sass' scoped>
</style>

