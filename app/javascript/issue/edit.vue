<template lang='pug'>
  b-form(@submit="submit")
    .row
      .col-12
        b-form-input(
          type="text",
          v-model="form.attributes.title",
          required,
          placeholder="Title"
        )
        br
    .row
      .col-12
        #text
        input(id="hidden_text" type="hidden")
        br
    .row
      .col-6
        button.btn.btn-sm.btn-success(type='submit')
          .fa.fa-spinner.fa-spin(v-if='is_saving')
          | Save
      .col-6
        .btn-group.float-right
          router-link.btn.btn-sm.btn-secondary(to='/') Cancel
          .btn.btn-sm.btn-danger Delete
</template>

<script>
import Vue from 'vue'

import Editor from 'tui-editor'

export default {
  props: ['issue_id'],
  data () {
    return {
      is_saving: false,
      is_loaded: false,
      form_data: {
        attributes: {
          name: '',
          description: ''
        }
      }
    }
  },
  mounted() {
    var editor = new Editor({
      el: document.querySelector('#text'),
      initialEditType: 'markdown',
      previewStyle: 'tab',
      height: '300px',
      initialValue: this.form.attributes.description,
      events: {
        change: (event) => {
          this.setDescription(editor.getValue())
        }
      }
    })
  },
  computed: {
    form: {
      get() {
        if (!this.is_loaded) {
          this.form_data = JSON.parse(JSON.stringify(this.$store.getters.get({type: 'issues', id: this.issue_id})))
          this.is_loaded = true
        }
        return this.form_data
      }
    },
    issue() {
      return this.$store.getters.get({type: 'issues', id: this.issue_id})
    }
  },
  methods: {
    submit(event) {
      event.preventDefault()

      this.is_saving = true

      this.$store.dispatch('update', {
        entry: this.issue,
        payload: this.form_data,
      }).then(() => {
          this.is_saving = false
          this.$router.replace('/')
      })
    },
    setDescription(data) {
      this.form.attributes.description = data
    }
  }
}
</script>

<style lang='sass' scoped>
</style>
