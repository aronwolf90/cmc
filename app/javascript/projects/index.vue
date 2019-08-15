<template lang='pug'>
  .projects-index
    index-top-section(
      resource="projects",
      new-text="New project",
      :item-text-function="itemTextFunction",
    )
    
    br
    br
    
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
import IndexTopSection from '../components/index-top-section'
import IndexListItem from '../components/index-list-item'
import IndexSearchSectionItem from '../components/index-list-item' 

export default {
  components: {
    IndexTopSection,
    IndexListItem,
    IndexSearchSectionItem
  },
  asyncComputed: {
    result () {
      return this.$store.dispatch('initProjects')
    }
  },
  computed: {
    projects () {
      if (!this.result) return []
      return this.result.data
    }
  },
  methods: {
    itemTextFunction(project) {
      return project.name
    }
  }
}
</script>
