<template lang='pug'>
  show-container(v-if='issue')
    show-body
      router-view(:issue-id='issueId')
      hr.divider
      comments(:issue-id='issueId')
      br
    right-aside
      assigen(:issue-id='issueId')
      complexity(:issue-id='issueId')
      due-at(:issue-id='issueId')
      deadline-at(:issue-id='issueId')

</template>

<script>
import Router from 'vue-router'

import Show from 'issue/show'
import Edit from 'issue/edit'

import RightAside from 'components/right_aside'

import SpentTime from 'issue/spent_time'
import Assigen from 'issue/assigen'
import Complexity from 'issue/complexity'
import Comments from 'issue/comments'
import ShowContainer from 'components/show-container'
import ShowBody from 'components/show-body'
import DueAt from 'issue/due-at'
import DeadlineAt from 'issue/deadline-at'

const router = new Router({
  routes: [
    {
      path: '/',
      name: 'Show',
      component: Show
    },
    {
      path: '/edit',
      name: 'Edit',
      component: Edit
    }
  ]
})

export default {
  props: ['issueId'],
  router,
  components: {
    Show,
    Edit,
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
    this.$store.dispatch('initIssue', this.issueId)
    if (!window.location.hash) router.replace('/')
  },
  computed: {
    issue () {
      return this.$store.getters.entry({type: 'issues', id: this.issueId})
    }
  }
}
</script>

<style lang='sass' scoped>
</style>

