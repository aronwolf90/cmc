import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor(state, { children, parent, parent_types,
    parent_relationship_name, child_relationship_name }) {

    this.state = state
    this.children = children
    this.parent = parent
    this.parent_types = parent_types
    this.parent_relationship_name = parent_relationship_name
    this.child_relationship_name = child_relationship_name
  }
  perform() {
    this._clear()
    this._setOnParent()
    this._setOnChildren()
  }

  _clear() {
    for (let type of this.parent_types) {
      for (let child of this.children) {
        Utils.clearFromCollection(this.state, child, type,
          this.parent_relationship_name)
      }
    }
  }
  _setOnParent() {
    Utils.initRelationshipCollection(this.parent,
      this.parent_relationship_name)

    for (let child of this.children) {
      this.parent.relationships[this.parent_relationship_name].data
        .push(Utils.entryToRef(child))
    }
  }
  _setOnChildren() {
    for (let child of this.children) {
      Utils.setRelationshipEntry(
        child,
        this.child_relationship_name,
        Utils.entryToRef(this.parent)
      )
    }
  }
}
