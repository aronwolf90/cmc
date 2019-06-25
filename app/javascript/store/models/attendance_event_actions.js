const endpoint = '/api/v1'
const resource = 'attendance_events'

export default {
  attendanceEvents (context, startDate) {
    return context.dispatch('get', {
      endpoint,
      resource: `${resource}?page[number]=${startDate}`
    })
  },
  createAttendanceEvent (context, payload) {
    return context.dispatch('create', {
      endpoint,
      resource,
      payload
    })
  },
  updateAttendanceEvent (context, { payload, entry }) {
    return context.dispatch('update', {
      endpoint,
      payload,
      entry
    })
  },
  destroyAttendanceEvent (context, entry) {
    return context.dispatch('destroy', { entry })
  }
}
