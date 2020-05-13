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
import IndexListItem from '../components/index-list-item'
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
      page: 1
    }
  },
  asyncComputed: {
    result: {
      get () {
        return this.$store.dispatch('getProjects', this.page)
      },
      watch: ['page']
    }
  },
  computed: {
    projects () {
      if (!this.result) return []
      return this.result.data
    },
    pages () {
      if (!this.result) return 1
      return Math.ceil(this.result.meta.count/10)
    }
  },
  methods: {
    itemTextFunction(project) {
      return Utils.attribute(project, 'name')
    },
    linkGen(page) {
      return page === 1 ? '?' : `?page=${page}`
    }
  }
}
</script>
