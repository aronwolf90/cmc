<template lang='pug'>
  .comments
    .row(v-for='comment in comments')
      .col-12
        | {{ comment.attributes.content }}
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

export default {
  props: ['projectId'],
  data () {
    return {
      projectCommentRefs: [],
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
  created () {
    this.fetch()
  },
  computed: {
    comments () {
      return this.projectCommentRefs.map(ref => {
        return this.$store.getters.projectComment(ref.id)
      })
    },
    project () {
      return this.$store.getters.project(this.projectId)
    },
    currentUser () {
      return this.$store.getters.currentUser
    }
  },
  methods: {
    fetch () {
      this.$store.dispatch('getProjectComments', this.projectId).then(response => {
        this.projectCommentRefs = Utils.entryArrayToRef(response.data)
      })
    },
    comment () {
      this.newCommentData.relationships.project.data = this.project
      this.newCommentData.relationships.user.data = this.currentUser

      if (!this.newCommentData.attributes.content) return
      this.$store.dispatch(
        'createProjectComment',
        this.newCommentData
      ).then(response => {
        this.projectCommentRefs.push(response.data.data)
      })
      this.$refs.markdownEditor.clear()
      this.newCommentData.attributes.content = ""
    }
  }
}
</script>
