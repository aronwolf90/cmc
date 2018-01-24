import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor(state, child, parent, parent_relationship_name) {
    this.state =  state
    this.child = child
    this.parent = parent
    this.parent_relationship_name = parent_relationship_name
  }
  perform() {
    for (let entry of this.state[this.parent.type]) {
      this._entries().data.splice(this._index())
    }

  }
  _entries() {
    return this.parent.relationships[this.parent_relationship_name]
  }
  _index() {
    return this._entries().data.findIndex(local_entry => local_entry.id == this.child.id)
  }
}
