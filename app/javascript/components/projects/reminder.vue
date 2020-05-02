<template lang='pug'>
  .reminder
    .pull-right.b-button
      .fa.fa-check(@click="closeIssue")
    .title
      router-link.text-secondary(:to="`${projectId}/issues/${id}`")
        | {{ title }}
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'

export default {
  props: ['id', 'type', 'projectId'],
  computed: {
    issue () {
      return this.$store.getters.entry({
        id: this.id,
        type: this.type
      })
    },
    title () {
      return Utils.attribute(this.issue, 'title')
    }
  },
  methods: {
    closeIssue () {
      this.$store.dispatch('projectsShow/closeIssue', this.issue)
    }
  }
}
</script>

<style lang='sass' scoped>
  .reminder
    padding-top: 4px
    padding-bottom: 4px
    .title
      overflow: hidden
      text-overflow: ellipsis
      max-width: 150px
</style>
