<template lang='pug'>
  #issue(v-if='issue')
    .container-fluid
      router-view(:issue-id='issueId')
      hr.divider
      comments(:issue-id='issueId')
      br
    .right-aside
      assigen(:issue-id='issueId')
      complexity(:issue-id='issueId')

</template>

<script>
import Router from 'vue-router'

import Show from 'issue/show'
import Edit from 'issue/edit'

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
    'assigen': Assigen,
    'comments': Comments,
    'complexity': Complexity
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
  .container-fluid
    padding-top: 15px
    overflow-y: auto
    height: calc(100vh - 40px)
  .right-aside
    background-color: #f8f8f8
    border-left: 2px solid #e7e7e7
    width: 200px
    height: calc(100vh - 40px)

</style>
