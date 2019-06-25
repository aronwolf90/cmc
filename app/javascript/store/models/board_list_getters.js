export default {
  boardLists (store, getters) {
    return getters.collection('board-lists') || []
  }
}
