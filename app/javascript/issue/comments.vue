<template lang='pug'>
  .comments
    .row(v-for='comment in comments')
      .col-12
        | {{ comment.attributes.content }}
        hr.divider
    .row
      .col-12
        markdown-editor(ref='markdownEditor', v-on:valueChange='newCommentData.attributes.content=$event')
        br
    .row
      .col-12
        .btn.btn-sm.btn-success(@click='comment') Comment

</template>

<script>
import MarkdownEditor from '../markdown_editor'

export default {
  props: ['issueId'],
  components: {
    'markdown-editor': MarkdownEditor
  },
  data () {
    return {
      newCommentData: {
        attributes: {
          content: ''
        }
      },
      editor: null
    }
  },
  created () {
    this.$store.dispatch('getContext', this.issueId)
  },
  computed: {
    comments () {
      return this.$store.getters['issues-show/comments']
    },
    issue () {
      return this.$store.getters.entry({id: this.issueId, type: 'issues'})
    },
    currentUser () {
      return this.$store.getters.currentUser
    }
  },
  methods: {
    comment () {
      if (!this.newCommentData.attributes.content) return
      this.$store.dispatch('createComment', {
        issue: this.issue,
        user: this.currentUser,
        attributes: this.newCommentData.attributes
      })
      this.$refs.markdownEditor.clear()
      this.newCommentData.attributes.content = ""
    }
  }
}
</script>
