import * as Utils from '../../utils'
import Vue from 'vue/dist/vue.common'

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
        this._clearFromCollection(this.state, child, type,
          this.parentRelationshipName)
      }
    }
  }
  _setOnParent () {
    this._initRelationshipCollection(this.parent,
      this.parentRelationshipName)

    for (let child of this.children) {
      this.parent.relationships[this.parentRelationshipName].data
        .push(Utils.entryToRef(child))
    }
  }
  _setOnChildren () {
    for (let child of this.children) {
      this._setRelationshipEntry(
        child,
        this.childRelationshipName,
        Utils.entryToRef(this.parent)
      )
    }
  }
  _clearFromCollection (state, entry, type, relationshipName) {
    for (let collectionEntry of Utils.getCollection(state, type)) {
      if (!collectionEntry.relationships) continue
      if (!collectionEntry.relationships[relationshipName]) continue

      let relationship = collectionEntry.relationships[relationshipName].data
      let index = relationship.findIndex((refEntry) => {
        return refEntry.id === entry.id && refEntry.type === entry.type
      })
      if (index > -1) relationship.splice(index, 1)
    }
  }
  _initRelationshipCollection (entry, relationshipName) {
    if (!entry.relationships) Vue.set(entry, 'relationships', {})
    if (!entry.relationships[relationshipName]) {
      Vue.set(entry.relationships, relationshipName, {})
    }
    if (!entry.relationships[relationshipName].data) {
      Vue.set(entry.relationships[relationshipName], 'data', [])
    }
  }
  _setRelationshipEntry (entry, relationshipName, associatedEntry) {
    if (!entry.relationships) Vue.set(entry, 'relationships', {})
    if (!entry.relationships[relationshipName]) {
      Vue.set(entry.relationships, relationshipName, {})
    }
    if (!entry.relationships[relationshipName].data) {
      Vue.set(entry.relationships[relationshipName], 'data', associatedEntry)
    }
  }
}
