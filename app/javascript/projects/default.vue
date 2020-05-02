<template lang='pug'>
  div
    b-button-group.pull-right
      b-button(
        variant="outline-secondary",
        :to="`/administration/projects/${id}/edit`",
        size="sm"
      )
        .fa.fa-edit
      b-button(
        variant="outline-danger",
        @click="destroy",
        size="sm"
      )
        .fa.fa-trash
    h4 {{ name }}
    markdown-viewer(:value='description')
</template>

<script>
import MarkdownViewer from '../markdown_viewer'
import { Utils } from 'vuex-jsonapi-client'

export default {
  props: ['id'],
  components: {
    MarkdownViewer
  },
  computed: {
    project () {
      return this.$store.getters['projectsShow/project']
    },
    name () {
      return Utils.attribute(this.project, 'name')
    },
    description () {
      return Utils.attribute(this.project, 'description')
    }
  }
}
</script>
