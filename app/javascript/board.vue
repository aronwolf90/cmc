<template lang='pug'>
  .issues_board
    .issues_board-header
      .row
        .col-md-10
          b-form-input(type='text', placeholder='Search', size='sm')
        .col-md-2
          span(v-on:click='visitAdd($event)')
            b-button.pull-right(variant='outline-secondary', size='sm', href='`${add_link}`')
              .fa.fa-plus
              |&nbsp add list

    .row.issues_board-row
      draggable.body.issues_board-body(v-model='board_lists')
        template(v-for='board_list in board_lists')
          list(:list_id='board_list.id')

</template>

<script>
import draggable from 'vuedraggable'
import list from 'board/list'

export default {
  components: {
    draggable,
    'list': list
  },
  created () {
    this.$store.dispatch('initBoardsLists')
  },
  computed: {
    board_lists: {
      get () {
        return this.$store.getters.getAll('board-lists').slice().sort(
          (first, second) => {
            return first.attributes['ordinal-number'] -
              second.attributes['ordinal-number']
          }
        )
      },
      set (value) {
        for (let i = 0; i < value.length; i++) {
          this.$store.dispatch('updateBoardList', {
            entry: value[i],
            attributes: { 'ordinal-number': i }
          })
        }
      }
    },
    add_link () {
      return '/administration/board_lists/new'
    }
  },
  methods: {
    visitAdd (event) {
      Turbolinks.visit(this.add_link) /* eslint-disable-line no-undef */
      event.preventDefault()
    }
  }
}
</script>

<style lang='sass' scoped>
  .issues_board-row
    height: 100%
  .issues_board
    height: 100%
    .issues_board-header
      margin-bottom: 10px
    .issues_board-body
      overflow-x: scroll
      white-space: nowrap
      heigth: 100%
      padding-left: 13px
</style>
