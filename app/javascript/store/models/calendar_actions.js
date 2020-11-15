export default {
  destroyCalendeasGoogleIntegration (context) {
    return context.dispatch('destroy', 'calendars/google_integration')
  }
}
