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
            h5#exampleModalLabel.modal-title Modal title
            button.close(type='button', data-dismiss='modal', aria-label='Close')
              span(aria-hidden='true') ×
          .modal-body
            label
              | Title
              input.form-control(v-model='attributes.title')
            | &nbsp; 
            label
              | Date
              input.form-control(v-model="attributes['start-time']")
          .modal-footer
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
     attributes: {
       title: null,
       'start-time': null
     }
   }
  },
  methods: {
   update () {
     this.$store.dispatch('updateEvent', {
       entry: this.event,
       attributes: this.attributes
     })
    }
  },
  computed: {
    event () {
      return this.$store.getters.entry({
        type: 'events',
        id: this.eventId
      })
    }
  },
  watch: {
    event () {
      if (this.loadedId == this.eventId) return
      this.loadedId = this.eventId
      this.attributes.title = 
        Utils.attribute(this.event, 'title')
      this.attributes['start-time'] = 
        Utils.attribute(this.event, 'start-time')
    }
  }
}
</script>

<style lang='sass' scoped>
.modal-content
  box-shadow: 0 1px 4px rgba(0, 0, 0, .3)
</style>
