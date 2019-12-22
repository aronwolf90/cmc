<template lang='pug'>
  #issue(v-if='issue')
    .container-fluid
      router-view(:issue-id='issueId')
      hr.divider
      comments(:issue-id='issueId')
      br
    right-aside
      assigen(:issue-id='issueId')
      complexity(:issue-id='issueId')

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
    RightAside
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
#issue
  display: flex
  margin-right: -14px
  margin-top: -35px
  height: calc(100% + 16px)
  .container-fluid
    padding-top: 15px
    overflow-y: auto
</style>

