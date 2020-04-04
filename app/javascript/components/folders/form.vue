<template lang='pug'>
  b-form(@submit.prevent="$emit('submit')")
    b-form-group(
      id="input-name-label",
      label="Name:",
      label-for="input-name"
    )
      b-form-input(
        id="input-name",
        v-model="value.attributes.name",
        :state="errorStatus('attributes/name')",
        type="text"
      )
      b-form-invalid-feedback(
        v-for="error in findErrors('attributes/name')"
      )
        | {{ error.detail }}
    b-form-group(
      id="folder-label",
      label="Folder:",
      label-for="folder"
    )
      b-form-select(
        v-model='value.folder',
        id='folder',
        :state="errorStatus('data/relationships/folder')",
        :options='folders'
      )
      b-form-invalid-feedback(
        v-for="error in findErrors('data/relationships/folder')"
      )
        | {{ error.detail }}

    slot
    br
    br
</template>

<script>
import InputFile from 'components/inputs/file'

export default {
  components: {
    InputFile
  },
  props: ['value', 'errors', 'folders', 'projectFolder'],
  computed: {
    folderOptions () {
      this.folders.map(folder => {
        if (Utils.esameRef(folder, projectFolder)) {
          return { value: Utils.entryToRef(folder), text: "" }
        } else {
          return {
            value: Utils.entryToRef(folder),
            text: Utils.attribute(folder, 'name')
          }
        }
      })
    }
  },
  methods: {
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
    setDocumentFile (documentFile) {
      this.documentFile = documentFile
    },
  },
  watch: {
    value () {
      this.$emit('input', this.value)
    }
  },
}
</script>

<style lang='sass'>
.b-form-file.is-invalid+.invalid-feedback
  display: block
</style>
