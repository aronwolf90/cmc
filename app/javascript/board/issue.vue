<template lang='pug'>
  .card.issue
    .card-body.issue-body.row
      .col-10.text
        a(v-bind:href="show_path")
          | {{ issue.attributes.title }}
      .col-2
        .text-muted(v-bind:href="edit_path")
          .fa.fa-edit
</template>

<script>

export default {
  props: ['issue_id', 'board_list_id'],
  computed: {
    issue() {
      return this.$store.state.issues.find(issue => issue.id == this.issue_id)
    },
    show_path() {
      return `/administration/board_lists/${this.board_list_id}/issues/${this.issue_id}`
    },
    edit_path() {
      return `/administration/board_lists/${this.board_list_id}/issues/${this.issue_id}/edit`
    }
  }
}

</script>

<style lang='sass' scoped>
  .issue
    margin: 5px
    box-shadow: 0 1px 2px rgba(186,186,186,0.5)
    .issue-body
      padding: 0.5rem
      .text
        overflow: hidden
        text-overflow: ellipsis
        a
          color: black
</style>
