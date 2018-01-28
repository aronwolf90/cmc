import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor(state, parent, child, relationship_name) {
    this.state = state
    this.parent = parent
    this.child = child
    this.relationship_name = relationship_name
  }
  perform() {
    this._initialize()
    this._set_relationship()
  }

  _initialize() {
    if (!this._relationships()) this.child.relationships = {}
    if (!this._relationship()) this._relationships()[this.relationship_name] = {}
  }
  _set_relationship() {
    this._relationship().data = this._relationship_entry()
  }

  _relationships() {
    return this.child.relationships
  }
  _relationship() {
    return this._relationships()[this.relationship_name]
  }
  _relationship_entry() {
    return { id: this.parent.id, type: this.parent.type }
  }
}
