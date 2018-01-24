import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor(state, parent, child, relationship_name) {
    this.state =  state
    this.parent = parent
    this.child = child
    this.relationship_name = relationship_name
  }
  perform() {
    this._initialize()
    this._add_to_relationship()
  }

  _initialize() {
    if (!this.parent.relationships) this.parent.relationships = {}
    if (!this._relationship()) parent.relationships[this.relationship_name] = {}
    if (!this._relationship_data()) this._relationship().data = []
  }
  _add_to_relationship() {
    this._relationship_data().push(this._associated_entry())
  }

  _relationship() {
    return this.parent.relationships[this.relationship_name]
  }
  _relationship_data() {
    return this._relationship().data
  }
  _associated_entry() {
    return { id: this.child.id, type: this.child.type }
  }
}
