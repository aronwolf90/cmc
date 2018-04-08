export default class {
  constructor ({ state, name }) {
    this.state = state
    this.name = name
  }
  perform () {
    if (!this.state.meta) return
    if (!this.state.meta[this.name]) return

    return this.state.meta[this.name].info
  }
}
