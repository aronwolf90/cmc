import * as Utils from '../../utils'

export default class {
  constructor ({ state, name }) {
    this.state = state
    this.name = name
  }
  perform () {
    if (!this.state.meta) return
    if (!this.state.meta[this.name]) return
    if (!this.state.meta[this.name].data) return

    return Utils.get(this.state, this.state.meta[this.name].data)
  }
}
