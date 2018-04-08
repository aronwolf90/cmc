import * as Utils from '../../utils'

export default class {
  constructor ({ state, entry, name }) {
    this.state = state
    this.entry = entry
    this.name = name
  }
  perform () {
    if (!this.entry) return
    if (!this.entry.relationships) return
    if (!this.entry.relationships[this.name]) return
    if (!this.entry.relationships[this.name].data) return

    let associated = this.entry.relationships[this.name].data
    if (!this.entry.relationships || !this.entry.relationships[this.name]) return
    return Utils.get(this.state, associated)
  }
}
