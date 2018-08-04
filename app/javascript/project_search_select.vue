<template lang='pug'>
  .search
    b-form-input(
      type='text', 
      v-model='searchText', 
      placeholder='Search',
      @blur.native="focused = false",
      @focus.native="focused = true"
    )
    .items(v-if="projects.length && focused")
      project-search-select-item(
        v-for="project in projects", 
        :project-id="project.id",
        :key="project.id"
      )
</template>

<script>
import ProjectSearchSelectItem from './project_search_select_item'
 
export default {
  data () {
    return { searchText: '', focused: false }
  },
  components: {
    ProjectSearchSelectItem
  },
  created () {
    this.$store.dispatch('initProjects')
  },
  computed: {
    projects () {
      if (this.searchText === '') return [] 
      return this.$store.getters.relevantProjects(this.searchText) || []
    }
  }
}
</script>

<style lang='sass' scoped>
.search
  position: relative
  .items
    position: absolute
    z-index: 1000
    background: white
    width: 460px
    border: 1px solid lightgrey
    margin-left: 1px
    max-height: 400px
    overflow-y: auto
    box-shadow: 0 1px 7px 0 rgba(0, 0, 0, .3)
    padding: 4px
</style>
