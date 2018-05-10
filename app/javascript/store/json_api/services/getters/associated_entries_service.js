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

    return this.entry.relationships[this.name].data.map(localEntry => {
      return Utils.get(this.state, localEntry)
    }).filter(entry => entry)
  }
}
