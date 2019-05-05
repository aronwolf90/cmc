<template lang='pug'>
  .attendances
    .table-responsive
      table.table.table-bordered 
        thead
          th
          header-cell(
            v-for='attendanceDay in attendanceDays',
            :key='attendanceDay.id',
            :attendance-day-id='attendanceDay.id'
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
      form: {
        email: ''
      }
    }
  },
  created () {
    this.$store.dispatch('attendanceEvents')
  },
  computed: {
    startDate () {
      return window.location.search['start-date']
    },
    currentAttendanceDayType () {
      return this.currentAttendanceDay && this.currentAttendanceDay.type
    }
  },
  asyncComputed: {
    users: {
      get () {
        return this.$store.dispatch('users') 
      },
      default: []
    },
    attendanceDays: {
      get () {
        return this.$store.dispatch(
          'attendanceDays',
          this.startDate
        )
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
    onSubmit () {
    },
    onReset () {
    }
  }
}
</script>
