<template lang="pug">
  .comments
    .row(v-for="comment in comments")
      .col-12
        | {{ comment.attributes.content }}
        hr.divider
    .row
      .col-12
        #new_comment
        br
    .row
      .col-12
        .btn.btn-sm.btn-success(@click="comment") Comment

</template>

<script>
import Editor from "tui-editor"

export default {
  props: ["issue_id"],
  data() {
    return {
      new_comment_data: {
        attributes: {
          content: ""
        }
      }
    }
  },
  created() {
    this.$store.dispatch('initContext', this.issue_id)
  },
  mounted() {
    let editor = new Editor({
      el: document.querySelector("#new_comment"),
      initialEditType: "markdown",
      previewStyle: "tab",
      height: "150px",
      events: {
        change: (event) => {
          this.new_comment_data.attributes.content = editor.getValue()
        }
      }
    })
  },
  computed: {
    comments() {
      let issue = this.$store.getters.get({type: "issues", id: this.issue_id})
      return this.$store.getters.getAssociatedEntries({entry: issue, name: "comments"})
    },
    issue() {
      return this.$store.getters.get({id: this.issue_id, type: "issues"})
    },
    context() {
      return this.$store.getters.get({id: "context", type: "contexts"})
    },
    currentUser() {
      return this.$store.getters.getAssociatedEntry({entry: this.context, name: "current-user"})
    }
  },
  methods: {
    comment() {
      this.$store.dispatch("createComment", {
        issue: this.issue,
        user: this.currentUser,
        attributes: this.new_comment_data.attributes
      })
    }
  }
}
</script>

<style lang="sass" scoped>
</style>
