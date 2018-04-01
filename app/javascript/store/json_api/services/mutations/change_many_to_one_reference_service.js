import * as Utils from '../../utils'

export default class {
  constructor ({ state, children, parent, parentTypes,
    parentRelationshipName, childRelationshipName }) {
    this.state = state
    this.children = children
    this.parent = parent
    this.parentTypes = parentTypes
    this.parentRelationshipName = parentRelationshipName
    this.childRelationshipName = childRelationshipName
  }
  perform () {
    this._clear()
    this._setOnParent()
    this._setOnChildren()
  }

  _clear () {
    for (let type of this.parentTypes) {
      for (let child of this.children) {
        Utils.clearFromCollection(this.state, child, type,
          this.parentRelationshipName)
      }
    }
  }
  _setOnParent () {
    Utils.initRelationshipCollection(this.parent,
      this.parentRelationshipName)

    for (let child of this.children) {
      this.parent.relationships[this.parentRelationshipName].data
        .push(Utils.entryToRef(child))
    }
  }
  _setOnChildren () {
    for (let child of this.children) {
      Utils.setRelationshipEntry(
        child,
        this.childRelationshipName,
        Utils.entryToRef(this.parent)
      )
    }
  }
}
