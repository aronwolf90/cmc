const endpoint = '/api/v1'

export default {
  attendanceDays (context) {
    return context.dispatch('initEntry', {
      endpoint,
      resource: 'attendance_days'
    })
  }
}
