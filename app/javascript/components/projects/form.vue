<template lang='pug'>
  b-form(@submit="submit")
    b-form-group(
      id="input-group-name",
      label="Name",
      label-for="input-name"
    )
      b-form-input(
        id="input-name",
        v-model="value.attributes.name",
        :state="errorStatus('attributes/name')",
        type="text"
      )
      b-form-invalid-feedback(
        v-for="error in findErrors('attributes/name')",
        :state="errorStatus('attributes/name')"
      )
        | {{ error.detail }}
    b-form-group(
      id="input-group-project-status",
      label="Project status",
      label-for="input-project-status"
    )
      b-form-select(
        id="input-name",
        v-model="value.relationships['project-status'].data",
        :options="projectStatuses",
        :state="errorStatus('attributes/relationships/project-status')",
        type="text"
      )
      b-form-invalid-feedback(
        v-for="error in findErrors('attributes/name')",
        :state="errorStatus('attributes/name')"
      )
        | {{ error.detail }}
    markdown-editor(
      v-model='value.attributes.description'
    )
    br
    b-form-group(
      id="input-group-contact",
      label="Contact",
      label-for="input-contact"
    )
      b-form-select(
        id="input-contact",
        v-model="value.relationships.contact.data",
        :options="contacts",
        :state="errorStatus('attributes/relationships/contact')",
        type="text"
      )
      b-form-invalid-feedback(
        v-for="error in findErrors('relationships/contact')",
        :state="errorStatus('relationships/contact')"
      )
        | {{ error.detail }}
    b-button(type="submit", variant="success") Save
    b-button-group.pull-right
      b-button(variant="danger", @click="destroy") Destroy
      b-button(variant="secondary", @click="$router.go(-1)") Cancel
</template>

<script>
export default {
  props: ['errors', 'value', 'id', 'contactRefs'],
  computed: {
    projectStatuses () {
      return [{ value: null, text: ''}]
      .concat((this.$store.getters.projectStatuses || [])
      .map(projectStatus => {
        return {
          value: { id: projectStatus.id, type: 'project-statuses' },
          text: projectStatus.attributes.name
        }
      }))
    },
    contacts () {
      return [{ value: null, text: ''}]
      .concat((this.contactRefs)
      .map(ref => {
        return {
          value: ref,
          text: this.$store.getters.entry(ref).attributes.name
        }
      }))
    },
    project () {
      if (!this.id) return null
      return this.$store.getters.project(this.id)
    }
  },
  watch: {
    value () {
      this.$emit('input', this.value)
    }
  },
  methods: {
    submit (event) {
      event.preventDefault()

      this.$emit('submit')
    },
    errorStatus (pointer) {
      let errors = this.findErrors(pointer)
      return errors.length == 0 ? null: false
    },
    findErrors (pointer) {
      return this.errors.filter(error => {
        return error.source.pointer.includes(pointer)
      })
      .filter((error, index, self) => {
        return self.findIndex(value => value.detail == error.detail) === index;
      })
    },
    destroy () {
      this.$store.dispatch('destroyProject', this.project).then(() => {
        this.$router.push('/administration/projects')
      })
    }
  }
}
</script>
