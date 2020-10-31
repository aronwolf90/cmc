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
      :number-of-pages="paginationPageCount",
      :value="paginationCurrentPage",
      use-router="",
      @page-click.prevent=""
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
  computed: {
    projects () {
      return this.$store.getters['projectsIndex/projects']
    },
    paginationPageCount () {
      return this.$store.getters['projectsIndex/paginationPageCount']
    },
    paginationCurrentPage () {
      return this.$store.getters['projectsIndex/paginationCurrentPage']
    },
    fetchingPage () {
      return this.$store.getters['projectsIndex/fetchingPage']
    }
  },
  async beforeRouteEnter (to, from, next) {
    const promise = window.store.dispatch(
      'projectsIndex/fetch',
      to.query.page
    )
    if (window.store.getters['projectsIndex/fetchingPage'] ===
      window.store.getters['projectsIndex/paginationCurrentPage']) {
      next()
    } else {
      await promise
      next()
    }
  },
  async beforeRouteUpdate (to, from, next) {
    await window.store.dispatch('projectsIndex/fetch', to.query.page)
    next()
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
