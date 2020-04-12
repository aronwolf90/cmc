<template lang='pug'>
  project-form(
    :errors='errors',
    @submit='submit',
    v-model="form",
    :contactRefs='contactRefs'
  )
</template>

<script>
import ProjectForm from 'components/projects/form'
import { Utils } from 'vuex-jsonapi-client'

export default {
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
          },
          contact: {
            data: null
          }
        }
      },
      errors: [],
      contactRefs: []
    }
  },
  created () {
    this.fetch()
  },
  methods: {
    submit (form) {
      this.$store.dispatch('createProject', this.form).then(response => {
        this.$router.push('/administration/projects')
      }).catch(({ status, data }) => {
        this.errors = data.errors
      })
    },
    fetch () {
      this.$store.dispatch('getContacts').then(response => {
        this.contactRefs = Utils.entryArrayToRef(response.data)
      })
    }
  }
}
</script>
