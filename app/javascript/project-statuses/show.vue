<template lang='pug'>
  .project-statuses-index
    ul.list-group.list-lines
      index-list-item(
        v-for="project in projects",
        resource="projects",
        :entry-type="project.type",
        :entry-id="project.id",
        :text="project.attributes.name",
        :editBtn="true"
      )
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import IndexListItem from 'components/index-list-item'

export default {
  props: ['id'],
  components: {
    IndexListItem
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
      return this.$store.dispatch('getProjectStatus', this.id)
        .then(result => {
          this.projectsRefs = result.data.relationships.projects.data
        })
    }
  }
}
</script>
