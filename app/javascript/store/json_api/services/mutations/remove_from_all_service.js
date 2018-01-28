import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor(state, child, parent_type, parent_relationship_name) {
    this.state =  state
    this.child = child
    this.parent_type = parent_type
    this.parent_relationship_name = parent_relationship_name
  }
  perform() {
    for (let entry of this._collection()) {
      if (!this._hasRelationship(entry)) continue
      this._relationship(entry).data.splice(this._index(entry))
    }
  }

  _collection() {
    return this.state[this.parent_type]
  }
  _hasRelationship(entry) {
    if (!entry.relationships) return false
    if (!this._relationship(entry)) return false
    if (!this._relationship(entry).data) return false

    return true
  }
  _relationship(entry) {
    return entry.relationships[this.parent_relationship_name]
  }
  _index(entry) {
    return this._relationship(entry).data.findIndex(local_entry => {
      local_entry.id == this.child.id && local_entry.type == this.child.type
    })
  }
}
