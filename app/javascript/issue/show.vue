<template lang='pug'>
  .show
    .row
      .col-sm-10
        h4 {{issue.attributes.title}}
      .col-sm-2
        .btn-group.float-right
          b-button(variant='outline-dark', size='sm', to='/edit')
            .fa.fa-edit
          .btn.btn-sm.btn-outline-danger
            .fa.fa-trash

    .body
      #description
</template>

<script>
import Editor from 'tui-editor'

export default {
  props: ['issue_id'],
  mounted () {
    Editor.factory({
      el: document.querySelector('#description'),
      viewer: true,
      height: '500px',
      initialValue: this.issue.attributes.description
    })
  },
  computed: {
    issue () {
      return this.$store.getters.get({type: 'issues', id: this.issue_id})
    }
  }
}
</script>

<style lang='sass' scoped>
</style>
