<template lang='pug'>
  b-form(@submit.prevent="submit", v-if="formLoaded")
    b-form-input(
      type="text",
      required,
      v-model="name",
      placeholder="Title",
      id="name-input"
    )
    br
    markdown-editor(
      v-model="description"
    )
    br
    button.btn.btn-sm.btn-success(type='submit')
      .fa.fa-spinner.fa-spin(v-if='isSaving')
      | Save
    .btn-group.float-right
      router-link.btn.btn-sm.btn-secondary(to='.') Cancel
      .btn.btn-sm.btn-danger(v-on:click='deleteIssue($event)') Delete
</template>

<script>
export default {
  params: ['id'],
  computed: {
    formLoaded () {
      return this.$store.getters['projectsShow/formLoaded']
    },
    name: {
      get () {
        return this.$store.getters['projectsShow/formName']
      },
      set (value) {
        this.$store.commit('projectsShow/formName', value)
      }
    },
    description: {
      get () {
        return this.$store.getters['projectsShow/formDescription']
      },
      set (value) {
        this.$store.commit('projectsShow/formDescription', value)
      }
    },
    project () {
      return this.$store.getters['projectsShow/project']
    }
  },
  methods: {
    submit () {
      this.$store.dispatch('projectsShow/updateProject').then(() => {
        this.$router.push('.')
      })
    }
  }
}
</script>
