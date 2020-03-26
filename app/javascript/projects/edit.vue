<template lang='pug'>
  project-form(
    :errors='errors',
    @submit='submit',
    v-model="form",
    :id="id",
    v-if="loaded"
  )
</template>

<script>
import ProjectForm from 'components/projects/form'
import { Utils } from 'vuex-jsonapi-client'

export default {
  props: ['id'],
  components: {
    ProjectForm
  },
  data () {
    return {
      form: {
        attributes: {
          name: null,
          description: null
        },
        relationships: {
          'project-status': {
            data: null
          }
        }
      },
      errors: [],
      loaded: false
    }
  },
  computed: {
    project () {
      return this.$store.getters.project(this.id)
    }
  },
  created () {
    this.$store.dispatch('getProject', this.id).then(response => {
      this.loaded = true
      this.form.attributes.name = response.data.attributes.name
      this.form.attributes.description = response.data.attributes.description
      this.form.relationships['project-status'].data =
        response.data.relationships['project-status'].data
    })
  },
  methods: {
    submit () {
      let path = null
      const newProjectStatus =
        Utils.relationship(this.form, 'project-status')
      const oldProjectStatus =
        Utils.relationship(this.project, 'project-status')
      const newProjectStatusId = newProjectStatus ? newProjectStatus.id : null
      const oldProjectStatusId = oldProjectStatus ? oldProjectStatus.id : null

      if (newProjectStatusId != oldProjectStatusId) {
        if (!newProjectStatusId) {
          path = '/administration/projects'
        } else {
          path = `/administration/project_statuses/${newProjectStatusId}`
        }
      }

      this.$store.dispatch('updateProject', {
        payload: this.form,
        project: this.project 
      }).then(() => {
        if (path) {
          this.$router.push(path)
        } else {
          this.$router.go(-1)
        }
      }).catch(({ status, data }) => {
        this.errors = data.errors
      })
    }
  }
}
</script>
