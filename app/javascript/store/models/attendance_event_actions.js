const endpoint = '/api/v1'
const resource = 'attendance_events'

export default {
  attendanceEvents (context) {
    return context.dispatch('initEntry', {
      endpoint,
      resource
    })
  },
  attendanceEventForDay (context, { day, userId }) {
    return context.dispatch('attendanceEvents').then(events => {
      return events.find(event => {
        return (
          (
            Date.parse(event.attributes['from-day']) <= Date.parse(day) &&
            Date.parse(event.attributes['to-day']) >= Date.parse(day)
          ) ||
            Date.parse(event.attributes['from-day']) === Date.parse(day)
        ) &&
          userId === event.relationships.user.data.id
      })
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
