<template lang='pug'>
  .reminder
    .pull-right.b-button
      .fa.fa-check(@click="closeIssue")
    router-link.text-secondary(:to="`/administration/issues/${id}`")
      | {{ title }}
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'

export default {
  props: ['id', 'type'],
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
</style>
