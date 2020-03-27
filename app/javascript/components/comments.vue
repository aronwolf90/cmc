<template lang='pug'>
  .comments
    .row(v-for='comment in comments')
      .col-12
        markdown-viewer(:value='comment.attributes.content')
        hr.divider
    .row
      .col-12
        markdown-editor(
          v-model='newCommentData.attributes.content',
          ref='markdownEditor'
        )
        br
    .row
      .col-12
        .btn.btn-sm.btn-success(@click='comment') Comment

</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import MarkdownViewer from 'markdown_viewer'

export default {
  props: ['projectId'],
  components: {
    MarkdownViewer
  },
  data () {
    return {
      newCommentData: {
        attributes: {
          content: ''
        },
        relationships: {
          project: {
            data: null
          },
          user: {
            data: null
          }
        }
      },
      editor: null
    }
  },
  computed: {
    comments () {
      return this.$store.getters['projectsShow/comments']
    }
  },
  methods: {
    comment () {
      this.newCommentData.relationships.project.data = this.project
      this.newCommentData.relationships.user.data = this.currentUser

      if (!this.newCommentData.attributes.content) return
      this.$store.dispatch('projectsShow/createComment', this.newCommentData)
      this.$refs.markdownEditor.clear()
      this.newCommentData.attributes.content = ""
    }
  }
}
</script>
