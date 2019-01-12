<template lang='pug'>
  .card.column(v-if='boardList')
    .card-header
      .text.pull-left {{ name }}
      a.btn.btn-sm.btn-outline-secondary.pull-right(v-on:click="visitAdd($event)", :href="addLink")
        .fa.fa-plus
      a.btn.btn-sm.btn-link.pull-right.text-muted(:href="editLink")
        .fa.fa-edit

      .clearfix
    draggable.body(v-model="issues", :options="{group:'issues'}")
      issue(v-for='issue in issues', :key='issue.id', :issue-id="issue.id", :board-list-id="boardList.id")

</template>

<script>
import draggable from 'vuedraggable'
import issue from './issue'
import { Utils } from 'vuex-jsonapi-client'

export default {
  components: {
    draggable,
    'issue': issue
  },
  props: { 'list-id': { required: true } },
  data () {
   return { local: { issues: [] } }
  },
  created () {
    this.$store.dispatch('initRelatedCollection', {
      entry: this.boardList,
      name: 'issues' 
    }).then(issues => {
      this.local.issues = issues
    })
  },
  computed: {
    boardList () {
      return this.$store.getters.entry({ type: 'board-lists', id: this.listId })
    },
    name () {
      return Utils.attribute(this.boardList, 'name')
    },
    addLink () {
      return `/administration/board_lists/${this.boardList.id}/issues/new`
    },
    editLink () {
      return `/administration/board_lists/${this.boardList.id}/edit`
    },
    issues: {
      get () {
        return this.local.issues
      },
      set (issues) {
        for (let i = 0, j = 0; i < issues.length && j < this.local.issues.length; i++,j++ ) {
          if (issues[i] == this.local.issues[j]) continue
          this.$store.dispatch('updateIssue', {
            entry: issues[i],
            attributes: { 'ordinal-number': i },
            boardList: this.boardList
          })
          if (issues[i+1] == this.local.issues[j]) i++
          if (issues[i] == this.local.issues[j+1]) j++
        }
        this.local.issues = issues
      }
    }
  },
  methods: {
    destroy () {
      return this.$store.dispatch('destroy', { entry: this.boardList })
    },
    visitAdd (event) {
      Turbolinks.visit(this.addLink) /* eslint-disable-line no-undef */
      event.preventDefault()
    }
  }
}
</script>

<style lang='sass' scoped>
  .column
    display: inline-block
    vertical-align: text-top
    margin-right: 13px
    width: 300px
    .body
      background-color: #fbfbfb
      min-height: 20px
      .issue
        margin: 5px
        box-shadow: 0 1px 2px rgba(186,186,186,0.5)
        .issue-body
          padding: 0.5rem
          .text
            overflow: hidden
            text-overflow: ellipsis
</style>
