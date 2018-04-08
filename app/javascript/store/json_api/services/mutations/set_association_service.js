export default class {
  constructor ({ parent, child, relationshipName }) {
    this.parent = parent
    this.child = child
    this.relationshipName = relationshipName
  }
  perform () {
    this._initialize()
    this._setRelationship()
  }

  _initialize () {
    if (!this._relationships()) this.child.relationships = {}
    if (!this._relationship()) this._relationships()[this.relationshipName] = {}
  }
  _setRelationship () {
    this._relationship().data = this._relationshipEntry()
  }

  _relationships () {
    return this.child.relationships
  }
  _relationship () {
    return this._relationships()[this.relationshipName]
  }
  _relationshipEntry () {
    if (!this.parent) return null
    return { id: this.parent.id, type: this.parent.type }
  }
}
