<template lang='pug'>
  .project-show
    b-button-group.pull-right
      b-button(
        variant="outline-secondary",
        :href="`/administration/projects/${id}/edit`",
        @click.prevent="visitEditPath",
        size="sm"
      )
        .fa.fa-edit
      b-button(
        variant="outline-danger",
        @click="destroy",
        size="sm"
      )
        .fa.fa-trash
    h4 {{ name }}
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'

export default {
  props: ['id'],
  created () {
    this.fetch()
  },
  computed: {
    project () {
      return this.$store.getters.project(this.id)
    },
    name () {
      return Utils.attribute(this.project, 'name')
    }
  },
  methods: {
    destroy () {
      this.$store.dispatch('destroyProject', this.project).then(() => {
        Turbolinks.visit("/administration/projects")
        this.$router.push('/administration/projects')
      })
    },
    fetch () {
      this.$store.dispatch('getProject', this.id)
    },
    visitEditPath () {
      Turbolinks.visit(`/administration/projects/${this.id}/edit`)
    }
  }
}
</script>

<style lang='sass' scoped>
</style>
