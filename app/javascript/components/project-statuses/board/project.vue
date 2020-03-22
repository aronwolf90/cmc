<template lang='pug'>
  .card.project
    .card-body.project-body.row
      .col-12.text
        router-link(:to='showPath')
          | {{ name }}
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'

export default {
  props: { 
    'project-id': { required: true }
  },
  computed: {
    project () {
      return this.$store.getters.project(this.projectId)
    },
    showPath () {
      return `/administration/projects/${this.projectId}`
    },
    name () {
      return Utils.attribute(this.project, 'name')
    }
  }
}

</script>

<style lang='sass' scoped>
  .project
    margin: 5px
    box-shadow: 0 1px 2px rgba(186,186,186,0.5)
    .project-body
      padding: 0.5rem
      .text
        overflow: hidden
        text-overflow: ellipsis
        a
          color: black
</style>
