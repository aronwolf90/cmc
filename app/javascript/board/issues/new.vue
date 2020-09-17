<template lang='pug'>
  b-form(@submit="submit")
    text-input(
      id="input-title",
      :errors="errors",
      v-model="form.attributes.title",
      label="Title",
      error-path="attributes/title"
    )
    project-select(
      label="Project",
      v-model="form.relationships.project.data",
      v-if="isGlobalBoard",
      :errors="errors",
      error-path="relationships/project"
    )
    br
    markdown-editor(v-model='form.attributes.description')
    br
    b-button(type="submit", variant="success") Create issue
    b-button.pull-right(variant="secondary", to="../..") Cancel
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import TextInput from 'components/form-inputs/text'
import ProjectSelect from 'components/project-select'

export default {
  components: {
    TextInput,
    ProjectSelect
  },
  props: ['boardListId'],
  data () {
    return {
      form: {
        attributes: {
          title: null,
          description: null
        },
        relationships: {
          project: {
            data: null
          }
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
    },
    isGlobalBoard () {
      return Utils.attribute(this.$store.getters.context, 'global-board')
    }
  },
  methods: {
    fetch () {
      this.$store.dispatch('getBoardList', this.boardListId)
      this.$store.dispatch('getProjects')
      this.$store.dispatch('getContext')
      this.$store.dispatch('getSelectedProject').then(() => {
        this.form.relationships.project.data = Utils.entryToRef(this.selectedProject)
      })
    },
    submit (event) {
      event.preventDefault()
      const project = this.form.relationships.project.data

      const payload = {
        attributes: this.form.attributes,
        relationships: {
          'board-list': {
            data: this.boardList
          },
          'project': {
            data: project
          }
        }
      }

      if (!payload.relationships.project.data) {
        delete payload.relationships.project
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
