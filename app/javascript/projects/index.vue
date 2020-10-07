<template lang='pug'>
  .projects-index
    index-top-section(
      resource="projects",
      new-text="New project",
      :item-text-function="itemTextFunction",
    )
    br
    br
    table.table
      thead
        th.col Name
        th.col Status
        th.col
      tbody
        project-index-item(
          v-for="project in projects",
          :key="project.id"
          :project-id="project.id",
          :project-type="project.type"
        )
    b-pagination-nav(
      :link-gen="linkGen",
      :number-of-pages="pages",
      v-model="page",
      use-router=""
    )
</template>

<script>
import IndexTopSection from '../components/index-top-section'
import IndexSearchSectionItem from '../components/index-list-item'
import ProjectIndexItem from 'components/projects/project-index-item'
import { Utils } from 'vuex-jsonapi-client'

export default {
  components: {
    IndexTopSection,
    ProjectIndexItem,
    IndexSearchSectionItem
  },
  data () {
    return {
      count: 1,
      page: 1,
      projectRefs: []
    }
  },
  beforeRouteEnter (to, from, next) {
    window.store.dispatch('getProjects', to.query.page).then(result => {
      next(vm => {
        vm.count = result.meta.count
        vm.page = to.query.page || 1
        vm.projectRefs = Utils.entryArrayToRef(result.data)
      })
    })
  },
  beforeRouteUpdate (to, from, next) {
    window.store.dispatch('getProjects', to.query.page).then(result => {
      this.count = result.meta.count
      this.page = to.query.page || 1
      this.projectRefs = Utils.entryArrayToRef(result.data)
      next()
    })
  },
  computed: {
    pages () {
      return Math.ceil(this.count / 10)
    },
    projects () {
      return this.projectRefs.map(ref => {
        return this.$store.getters.entry(ref)
      })
    }
  },
  methods: {
    itemTextFunction (project) {
      return Utils.attribute(project, 'name')
    },
    linkGen (page) {
      return page === 1 ? '?' : `?page=${page}`
    }
  }
}
</script>
