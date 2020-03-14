<template lang='pug'>
  span.projects-left-aside
    left-aside-item(path="/administration/projects", notShowActive="true")
      i.fa.fa-tasks.fa-lg
        | &nbsp; &nbsp; Projects
    left-aside-item(path="/administration/projects")
      | All
    left-aside-item(
      :path="`/administration/project_statuses/${projectStatus.id}`",
      v-for="projectStatus in projectStatuses", :key='projectStatus.id'
    )
      | {{ projectStatus.attributes.name }}
    left-aside-item.text-center(path="/administration/project_statuses/new")
      i.fa.fa-plus(aria-hidden="true")
</template>

<script>
import LeftAsideItem from 'components/left-aside-item'
import { Utils } from 'vuex-jsonapi-client'

export default {
  components: {
    LeftAsideItem
  },
  data () {
    return {
      projectStatusesRefs: []
    }
  },
  created () {
    this.fetch()
  },
  watch: {
    '$route' (to, from) {
      this.fetch()
    }
  },
  computed: {
    projectStatuses () {
      return this.projectStatusesRefs.map(ref => {
        return this.$store.getters.projectStatus(ref.id)
      })
    }
  },
  methods: {
    fetch () {
      this.$store.dispatch('getProjectStatuses').then(response => {
        this.projectStatusesRefs = Utils.entryArrayToRef(response.data)
      })
    }
  }
}
</script>
