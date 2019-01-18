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
    .more(v-if='showMore') 
      .text(v-on:click.self='loadMore') Load more

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
  created () {
    this.$store.dispatch('initRelatedCollection', {
      entry: this.boardList,
      name: 'issues' 
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
    showMore () {
      if (!this.boardList) return false
      if (!this.boardList.relationships['issues'].links) return false
      return !!this.boardList.relationships['issues'].links.next
    },
    issues: {
      get () {
        return this.$store.getters.associatedEntries({ entry: this.boardList, name: 'issues' })
      },
      set (issues) {
        for (let i = 0, j = 0; i < issues.length && j < this.issues.length; i++,j++ ) {
          if (issues[i] == this.issues[j]) continue
          this.$store.dispatch('updateIssue', {
            entry: issues[i],
            attributes: { 'ordinal-number': i },
            boardList: this.boardList
          })
          if (issues[i+1] == this.issues[j]) i++
          if (issues[i] == this.issues[j+1]) j++
        }
        this.$store.commit('changeManyToOneReference', {
          children: issues,
          parent: this.boardList,
          childRelationshipName: 'board-list',
          parentRelationshipName: 'issues',
          parentTypes: ['board-lists']
        })
        this.$store.commit('relataionshipLinks', {
          entry: this.boardList,
          association: 'issues',
          links: {
            next: `/api/v1/board_lists/${this.listId}/issues?more_id=${this.issues[this.issues.length - 1]}`
          }
        })
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
    },
    loadMore () {
      this.$store.dispatch('loadAssociationNextPageAccumulative', { 
        entry: this.boardList, 
        association: 'issues'
      })
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
    .more
      text-align: center
      .text
        display: inline-block
        &:hover
          text-decoration: underline
          cursor: pointer
</style>
