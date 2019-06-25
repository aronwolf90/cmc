<template lang='pug'>
  .attendances
    .text-center
      a.fa.fa-step-backward.fa-fw(:href='`?start-date=${prev}`')
      | {{ current }}
      a.fa.fa-step-forward.fa-fw(:href='`?start-date=${next}`')
    br
    .table-responsive
      table.table.table-bordered 
        thead
          th
          header-cell(
            v-for='attendanceDay in attendanceDays',
            :key='attendanceDay.id',
            :attendance-day-id='attendanceDay.id'
            :attendance-day-type='attendanceDay.type'
          )
        tbody
          tr(v-for='user in users')
            user-cell(:user-id='user.id', :type='user.type')
            body-cell(
              v-for='attendanceDay in attendanceDays',
              :attendanceDayId='attendanceDay.id',
              :userId='user.id',
              :userType='user.type',
              :key='attendanceDay.id',
              @showModal='showModal'
            )
    modal(
      v-if="currentAttendanceDay"
      :day="currentAttendanceDay.id",
      :userId="currentUser.id",
      :key="currentAttendanceDay.id + '-' + currentUser.id",
      ref='modal'
    )
</template>

<script>
import HeaderCell from 'attendances/header_cell'
import UserCell from 'attendances/user_cell'
import BodyCell from 'attendances/body_cell'
import Modal from 'attendances/modal'
 
export default {
  components: {
    HeaderCell,
    UserCell,
    BodyCell,
    Modal
  },
  data () {
    return {
      currentAttendanceDay: null,
      currentUser: null,
      prev: null,
      current: null,
      next: null,
    }
  },
  created () {
    this.$store.dispatch('users') 
  },
  computed: {
    startDate () {
      var urlParams = new URLSearchParams(location.search);
      return urlParams.get('start-date')
    },
    currentAttendanceDayType () {
      return this.currentAttendanceDay && this.currentAttendanceDay.type
    },
    users () {
      return this.$store.getters.users
    }
  },
  asyncComputed: {
    attendanceDays: {
      get () {
        return this.$store.dispatch(
          'attendanceDays',
          this.startDate
        ).then(response => {
          this.prev = response.links.meta.prev
          this.current = response.links.meta.current
          this.next = response.links.meta.next
          return response.data
        })
      },
      default: []
    },
    attendanceEvents: {
      get () {
        return this.$store.dispatch(
          'attendanceEvents',
          this.startDate
        ).then(response => response.data)
      },
      default: []
    }
  },
  methods: {
    showModal ({ day, user }) {
      this.currentAttendanceDay = day
      this.currentUser = user
      if (this.$refs.modal) this.$refs.modal.show()
    },
  },
  watch: {
    startDate () {
      this.$store.dispatch('attendanceEvents')
    }
  }
}
</script>
