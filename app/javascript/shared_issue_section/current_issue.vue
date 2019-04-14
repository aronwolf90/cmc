<template lang='pug'>
  .current-issue(v-if='currentIssue')
    a(v-bind:href='showPath', v-on:click='visitShow($event)')
      | {{ title }}

</template>

<script>
import { Utils } from 'vuex-jsonapi-client'

export default {
  created () {
    this.$store.dispatch('initCurrentIssue')
  },
  computed: {
    currentIssue () {
      return this.$store.getters.currentIssue
    },
    title () {
      return Utils.attribute(this.currentIssue, 'title')
    },
    boardListId () {
      if (!Utils.relationship(this.currentIssue, 'board-list')) return
      return Utils.relationship(this.currentIssue, 'board-list').id
    },
    showPath () {
      if (!this.currentIssue) return
      return `/administration/issues/${this.currentIssue.id}`
    }
  },
  methods: {
    visitShow (event) {
      Turbolinks.visit(this.showPath) /* eslint-disable-line no-undef */
      event.preventDefault()
    }
  }
}
</script>

<style lang='sass' scoped>
.current-issue
  padding: 10px
  text-align: center
  border-bottom: 1px solid #e7e7e7
  max-width: 170px
  a
    color: grey
    display: table-caption
    text-overflow: ellipsis
    overflow: hidden
    width: 153px

</style>
