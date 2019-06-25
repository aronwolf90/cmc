const endpoint = '/api/v1'
const resource = 'attendance_days'

export default {
  attendanceDays (context, startDate) {
    return context.dispatch('get', {
      endpoint,
      resource: `${resource}?page[number]=${startDate}`
    })
  }
}
