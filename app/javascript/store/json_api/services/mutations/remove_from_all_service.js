import * as Utils from '../../utils'

export default class {
  constructor ({ state, child, parentType, parentRelationshipName }) {
    this.state = state
    this.child = child
    this.parentType = parentType
    this.parentRelationshipName = parentRelationshipName
  }
  perform () {
    for (let entry of Object.values(this._collection())) {
      if (!this._hasRelationship(entry)) continue
      this._relationship(entry).data.splice(this._index(entry))
    }
  }

  _collection () {
    return this.state[this.parentType]
  }
  _hasRelationship (entry) {
    if (!entry.relationships) return false
    if (!this._relationship(entry)) return false
    if (!this._relationship(entry).data) return false

    return true
  }
  _relationship (entry) {
    return entry.relationships[this.parentRelationshipName]
  }
  _index (entry) {
    return this._relationship(entry).data.findIndex(localEntry => {
      return Utils.sameRef(entry, localEntry)
    })
  }
}
