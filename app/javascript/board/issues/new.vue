<template lang='pug'>
  b-form(@submit="submit")
    b-form-group(
      id="input-group-title",
      label="Title",
      label-for="input-title"
    )
      b-form-input(
        id="input-title",
        v-model="form.attributes.title",
        :state="errorStatus('attributes/title')",
        type="text"
      )
      b-form-invalid-feedback(
        v-for="error in findErrors('attributes/title')",
        :state="errorStatus('attributes/title')"
      )
        | {{ error.detail }}
    markdown-editor(v-model='form.attributes.description')
    br
    b-button(type="submit", variant="success") Create issue
    b-button.pull-right(variant="secondary", to="../..") Cancel
</template>

<script>
import MarkdownEditor from 'markdown_editor'

export default {
  components: {
    MarkdownEditor
  },
  props: ['boardListId'],
  data () {
    return {
      form: {
        attributes: {
          title: null,
          description: null
        }
      },
      errors: []
    }
  },
  created () {
    this.fetch()
  },
  computed: {
    boardList () {
      return this.$store.getters.boardList(this.boardListId)
    },
    selectedProject () {
      return this.$store.getters.selectedProject
    }
  },
  methods: {
    fetch () {
      this.$store.dispatch('getBoardList', this.boardListId)
      this.$store.dispatch('getSelectedProject')
    },
    submit (event) {
      event.preventDefault()

      const payload = {
        attributes: this.form.attributes,
        relationships: {
          'board-list': {
            data: this.boardList
          },
          'project': {
            data: this.selectedProject
          }
        }
      }
 
      this.$store.dispatch('createIssue', payload).then(() => {
        this.$store.dispatch('board/getBoardLists').then(() => {
          this.$router.push('../..')
        })
      }).catch(({ status, data }) => {
        this.errors = data.errors
      })
    },
    errorStatus (pointer) {
      let errors = this.findErrors(pointer)
      return errors.length == 0 ? null: false
    },
    findErrors (pointer) {
      return this.errors.filter(error => {
        return error.source.pointer.includes(pointer)
      })
      .filter((error, index, self) => {
        return self.findIndex(value => value.detail == error.detail) === index;
      })
    },
  }
}
</script>
