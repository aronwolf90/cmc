<template lang='pug'>
  #complexity(v-if='projects && currentUser')
    b-form-select(v-model='selected', :options='options', size="sm")
</template>

<script>
import * as Utils from '../store/json_api/utils'

export default {
  created () {
    this.$store.dispatch('initProjects')
    this.$store.dispatch('initCurrentUser')
  },
  computed: {
    options () {
      return [{ value: null, text: 'General board' }].concat(
        (this.projects || []).map(project => {
          return { value: project.id, text: project.attributes.name }
        })
      )
    },
    projects () {
      return this.$store.getters.metaCollection('projects')
    },
    currentUser () {
      return this.$store.getters.currentUser
    },
    selectedProject () {
      return Utils.relationship(this.currentUser, 'selected-project')
    },
    selected: {
      get () {
        if (this.selectedProject) {
          this.$store.dispatch('loadBoardLists', this.selectedProject.id)
          return this.selectedProject.id
        }
        this.$store.dispatch('loadBoardLists', undefined)
        return null
      },
      set (value) {
        this.$store.dispatch('updateUser', {
          entry: this.currentUser,
          selectedProject: this.$store.getters.entry({
            id: value, type: 'projects' }) || null
        })
      }
    }
  },
  watch: {
    /*
    * HACK: when click and return to this page turbolinks not preserve
    * the selected option so a few milliseconds appear wrong option. This
    * hack sole this
    */
    selected (value) {
      setTimeout(() => {
        if (value) {
          $(`#complexity option[value="${value}"]`).attr('selected', true)
        }
        else {
          $('#complexity option').first().attr('selected', true)
        }
      }, 10)
    }
  }
}
</script>
