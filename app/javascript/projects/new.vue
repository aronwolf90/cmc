<template lang='pug'>
  project-form(
    :errors='errors',
    @submit='submit',
    v-model="form"
  )
</template>

<script>
import ProjectForm from 'components/projects/form'

export default {
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
      errors: []
    }
  },
  methods: {
    submit (form) {
      this.$store.dispatch('createProject', this.form).then(response => {
        this.$router.push('/administration/projects')
      }).catch(({ status, data }) => {
        this.errors = data.errors
      })
    }
  }
}
</script>
