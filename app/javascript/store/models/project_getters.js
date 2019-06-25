export default {
  projects (store, getters) {
    return getters.collection('projects') || []
  }
}
