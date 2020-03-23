export default {
  updateProjectBoardList (context, { projectBoardList, payload }) {
    return context.dispatch('update', {
      entry: projectBoardList,
      payload
    })
  }
}
