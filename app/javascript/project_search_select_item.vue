<template lang='pug'>
.item 
  a(:href="link") {{ name }}
</template>

<script>
import * as Utils from './store/json_api/utils'
 
export default {
  props: ['projectId'],
  computed: {
    project () {
      return this.$store.getters.entry({
        id: this.projectId, 
        type: 'projects'
      })
    },
    name () {
      return Utils.attribute(this.project, 'name')
    },
    link () {
      return `/administration/projects/${this.project.id}/dashboard`
    }
  }
}
</script>

<style lang='sass' scoped>
a
  color: black
</style>
