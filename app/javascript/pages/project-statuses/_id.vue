<template lang='pug'>
  .project-status-show
    .project-status-show-header
      b-button-group.pull-right
        b-button(
          variant="outline-secondary",
          size="sm",
          :to="`/administration/project_statuses/${this.id}/project_board_lists/new`",
          v-if="projectBoard"
        )
          .fa.fa-plus
        b-button(
          variant="outline-secondary",
          size="sm",
          :to="`/administration/project_statuses/${this.id}/edit`"
        )
          .fa.fa-edit
        b-button(variant="outline-danger", size="sm", @click="destroy")
          .fa.fa-trash
      h4 {{ title }}
    board(v-if="projectBoard")
    template(v-else="")
      br
      ul.list-group.list-lines
        index-list-item(
          v-for="project in projects",
          resource="projects",
          :entry-type="project.type",
          :entry-id="project.id",
          :text="project.attributes.name",
          :editBtn="true",
          :key="project.id"
        )
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import IndexListItem from 'components/index-list-item'
import Board from 'components/project-statuses/board'

export default {
  props: ['id'],
  components: {
    IndexListItem,
    Board
  },
  data () {
    return {
      projectsRefs: []
    }
  },
  created () {
    this.fetch()
  },
  computed: {
    projectBoard () {
      return Utils.attribute(this.projectStatus, 'display-as') ===
        'board'
    },
    title () {
      return Utils.attribute(this.projectStatus, 'name')
    },
    projectStatus () {
      return this.$store.getters.projectStatus(this.id)
    },
    projects () {
      return this.projectsRefs.map(ref => {
        return this.$store.getters.project(ref.id)
      })
    }
  },
  watch: {
    'id': 'fetch'
  },
  methods: {
    fetch () {
      this.projectsRefs = []
      this.$store.dispatch('getProjectStatus', this.id)
        .then(result => {
          this.projectsRefs = result.data.relationships.projects.data
        })
      this.$store.dispatch('projects-board/fetch', this.id)
    },
    destroy () {
      return this.$store.dispatch('destroyProjectStatus', this.projectStatus)
        .then(result => {
          this.$router.push('/administration/projects')
        })
    }
  }
}
</script>

<style lang='sass' scoped>
  .project-status-show
    display: flex
    flex-flow: column
    height: 100%
</style>
