<template lang='pug'>
    #event-dialog.modal.fade(
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
              @click='create',
              data-dismiss='modal'
            ) Save changes
</template>

<script>
 
export default {
  data () {
   return {
     attributes: {
       title: '',
       'start-time': ''
     }
   }
  },
  methods: {
   create () {
     this.$store.dispatch('createEvent', {
       attributes: this.attributes
     })
   }
  }
}
</script>

<style lang='sass' scoped>
.modal-content
  box-shadow: 0 1px 4px rgba(0, 0, 0, .3)
</style>
