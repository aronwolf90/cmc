export default {
  destroyCalendersGoogleIntegration (context) {
    return context.dispatch('destroy', 'calenders/google_integration')
  }
}
