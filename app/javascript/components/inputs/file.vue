<template lang='pug'>
  b-form-group(
    label="File:",
    label-for="input-file"
  )
    b-form-file(
      id="input-file",
      placeholder="Choose a file...",
      @input="changeFile",
      drop-placeholder="Drop file here...",
      :state="errorStatus",
    )
    b-form-invalid-feedback(
      v-for="error in errors"
    )
      | {{ error.detail }}
</template>

<script>

export default {
  props: {
    errors: Array,
    endpoint: String,
    slizeSize: {
      default: 6*1024*1024
    }
  },
  methods: {
    changeFile (file) {
      let formData = new FormData()
      let headers = { 'Content-Type': 'multipart/form-data' }
      let nextSlice =  this.slizeSize + 1
      let blob = file.slice(0, nextSlice, file.type)
      let that = this

      formData.append('data[file]', blob, file.name)
      if (nextSlice <= file.size) {
        formData.append('data[not_finished]', true)
      }

      this.$store.getters.axios
        .post(this.endpoint, formData, { headers })
        .then(response => {
          that.uploadFile(
            nextSlice,
            file,
            response.data.data
          )
        })
    },
    uploadFile (start, file, result) {
      if (start > file.size) {
        this.$emit('input', result)
        return
      }

      let headers = { 'Content-Type': 'multipart/form-data' }
      let formData = new FormData()
      let nextSlice = start + this.slizeSize + 1;
      var blob = file.slice(start, nextSlice);
      let that = this

      formData.append('data[file]', blob)
      if (nextSlice <= file.size) {
        formData.append('data[not_finished]', true)
      }
      this.$store.getters.axios
        .put(`${this.endpoint}/${result.id}`, formData, { headers })
        .then(response => {
          that.uploadFile(nextSlice, file, result)
        })
    }
  },
  computed: {
    errorStatus () {
      return this.errors.length == 0 ? null: false
    },
  }
}

</script>

<style lang='sass' scoped>
</style>

