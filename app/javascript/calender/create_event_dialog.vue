<template lang='pug'>
    #create-event-dialog.modal.fade(
      tabindex='-1',
      role='dialog',
      data-backdrop="false",
      aria-labelledby='exampleModalLabel',
      aria-hidden='true'
    )
      .modal-dialog.modal-dialog-centered(role='document')
        .modal-content
          .modal-header
            h5#exampleModalLabel.modal-title Create event
            button.close(type='button', data-dismiss='modal', aria-label='Close')
              span(aria-hidden='true') ×
          .modal-body
            .row
              .col-12.label
                | Title
                input.form-control(v-model='form.title')
            .row
              .col-6.label
                | Date
                input.form-control(v-model='form.date')
              .col-6.label
                | Time
                .input-group
                  .input-group-prepend
                    .input-group-text
                      input(v-model='form.nonAllDay', type='checkbox')
                  template(v-if='form.nonAllDay')
                    input.form-control(v-model='form.startTime')
                    input.form-control(v-model='form.endTime')
                  input.form-control(v-else, disabled=true)
            .row
              .col-12.label
                | Description
                textarea.form-control(v-model='form.description')
          .modal-footer
            button.btn.btn-success(
              @click='create',
              data-dismiss='modal'
            ) Save
</template>

<script>
import * as Utils from 'store/json_api/utils'
 
export default {
  props: ['eventId'],
  data () {
   return {
     form: {
       title: null,
       date: null,
       startTime: null,
       endTime: null,
       nonAllDay: null,
       description: null
     }
   }
  },
  methods: {
   create () {
     this.$store.dispatch('createEvent', {
       attributes: {
         title: this.form.title,
         'start-time': `${this.form.date} ${this.form.startTime}`,
         'end-time': `${this.form.date} ${this.form.endTime}`,
         'all-day': !this.form.nonAllDay,
         'description': this.form.description
       }
     })
    }
  }
}
</script>

<style lang='sass' scoped>
.modal-content
  box-shadow: 0 1px 4px rgba(0, 0, 0, .3)
</style>
