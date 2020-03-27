<template lang='pug'>
  .project-show(v-if="project")
    b-button-group.pull-right
      b-button(
        variant="outline-secondary",
        :href="`/administration/projects/${id}/edit`",
        @click.prevent="visitEditPath",
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
    hr.divider
    comments(:projectId="id", v-if="project")
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import MarkdownViewer from '../markdown_viewer'
import Comments from 'components/comments'

export default {
  props: ['id'],
  components: {
    MarkdownViewer,
    Comments
  },
  created () {
    this.fetch()
  },
  computed: {
    project () {
      return this.$store.getters.project(this.id)
    },
    name () {
      return Utils.attribute(this.project, 'name')
    },
    description () {
      return Utils.attribute(this.project, 'description')
    }
  },
  methods: {
    destroy () {
      this.$store.dispatch('destroyProject', this.project).then(() => {
        Turbolinks.visit("/administration/projects")
        this.$router.push('/administration/projects')
      })
    },
    fetch () {
      this.$store.dispatch('projectsShow/fetch', this.id)
    },
    visitEditPath () {
      Turbolinks.visit(`/administration/projects/${this.id}/edit`)
    }
  }
}
</script>

<style lang='sass' scoped>
</style>
