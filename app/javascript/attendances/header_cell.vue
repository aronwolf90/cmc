<template lang='pug'>
  td.text-nowrap(:class='attendanceDay.attributes.kind') {{ day }}
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import dateFormat from 'dateformat'

export default {
  props: ['attendance-day-id'],
  computed: {
    attendanceDay () {
      return this.$store.getters.entry({ 
        id: this.attendanceDayId,
        type: "attendance-days"
      })
    },
    day () {
      let day = this.attendanceDay.attributes.day
      return dateFormat(day, 'ddd d')
    }
  }
}
</script>

<style lang='sass' scoped>
  .holiday-day, .weekend-day
    background-color: rgba(20,20,20,0.07)
</style>
