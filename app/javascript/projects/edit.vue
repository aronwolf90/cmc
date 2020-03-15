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

export default {
  props: ['id'],
  components: {
    ProjectForm
  },
  data () {
    return {
      form: {
        attributes: {
          name: null
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
      this.form.relationships['project-status'].data =
        response.data.relationships['project-status'].data
    })
  },
  methods: {
    submit () {
      this.$store.dispatch('updateProject', {
        payload: this.form,
        project: this.project 
      }).then(() => {
        const path = '/administration/projects'
        this.$router.push(path)
      }).catch(({ status, data }) => {
        this.errors = data.errors
      })
    }
  }
}
</script>
