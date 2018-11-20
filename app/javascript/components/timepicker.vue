<template lang='pug'>
  date-picker(v-on='$listeners', :config="options")
</template>

<script>
  import datePicker from 'vue-bootstrap-datetimepicker';
   
  export default {    
    data () {
      return {
        options: {
          format: 'HH:mm',
          useCurrent: false,
        }       
      }
    },
    components: {
      datePicker
    }
  }
</script>
