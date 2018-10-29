<template lang='pug'>
    #update-event-dialog.modal.fade(
      tabindex='-1',
      role='dialog',
      data-backdrop="false",
      aria-labelledby='exampleModalLabel',
      aria-hidden='true'
    )
      .modal-dialog.modal-dialog-centered(role='document')
        .modal-content
          .modal-header
            h5#exampleModalLabel.modal-title Edit event
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
          .modal-footer
            button.btn.btn-danger(
              @click='destroy',
              data-dismiss='modal'
            ) Delete
            button.btn.btn-success(
              @click='update',
              data-dismiss='modal'
            ) Save changes
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
       nonAllDay: null
     }
   }
  },
  methods: {
   update () {
     this.$store.dispatch('updateEvent', {
       entry: this.event,
       attributes: {
         title: this.form.title,
         'start-time': `${this.form.date} ${this.form.startTime}`,
         'end-time': `${this.form.date} ${this.form.endTime}`,
         'all-day': !this.form.nonAllDay
       }
     })
    },
    destroy () {
      this.$store.dispatch('destroyEvent', this.event)
    }
  },
  computed: {
    event () {
      return this.$store.getters.entry({
        type: 'events',
        id: this.eventId
      })
    },
    date () {
      let date = Utils.attribute(this.event, 'start-time')
      return date.substring(0, 10)
    },
    startTime () {
      let date = Utils.attribute(this.event, 'start-time')
      return date.substring(11, 19)
    },
    endTime () {
      let date = Utils.attribute(this.event, 'end-time')
      if (!date) return ''
      return date.substring(11, 19)
    }
  },
  watch: {
    event () {
      if (this.loadedId == this.eventId) return
      this.loadedId = this.eventId
      this.form.title = 
        Utils.attribute(this.event, 'title')
      this.form.nonAllDay =
        !Utils.attribute(this.event, 'all-day')
      this.form.date = this.date
      this.form.startTime = this.startTime
      this.form.endTime = this.endTime || this.startTime
    }
  }
}
</script>

<style lang='sass' scoped>
.modal-content
  box-shadow: 0 1px 4px rgba(0, 0, 0, .3)
</style>
