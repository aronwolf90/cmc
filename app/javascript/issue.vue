<template lang='pug'>
  #issue(v-if="is_loaded")
    .container-fluid
      router-view(:issue_id='issue_id')
      hr.divider
      comments(:issue_id='issue_id')
      br
    .right-aside
      assigen(:issue_id='issue_id')

</template>

<script>
import Router from 'vue-router'

import Show from 'issue/show'
import Edit from 'issue/edit'

import Assigen from 'issue/assigen'
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
  props: ['issue_id'],
  router,
  components: {
    Show,
    Edit,
    'assigen': Assigen,
    'comments': Comments

  },
  created () {
    this.$store.dispatch('initIssue', this.issue_id)
    if (!window.location.hash) router.replace('/')
  },
  computed: {
    is_loaded () {
      return this.$store.getters.entry({type: 'issues', id: this.issue_id}) !== undefined
    },
    issue: {
      get () {
        return this.$store.getters.entry({type: 'issues', id: this.issue_id})
      },
      set (value) {
        // this.$store.dispatch('updateIssue', value)
      }
    }
  }
}
</script>

<style lang='sass' scoped>
#issue
  display: flex
  margin-right: -15px
  .container-fluid
    overflow-y: scroll
    height: calc(100vh - 60px)
  .right-aside
    background-color: #f8f8f8
    margin-top: -22px
    border-left: 2px solid #e7e7e7
    width: 200px
    height: 100vh

</style>
