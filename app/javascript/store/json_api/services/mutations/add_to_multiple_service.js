export default class {
  constructor ({ parent, child, relationshipName }) {
    this.parent = parent
    this.child = child
    this.relationshipName = relationshipName
  }
  perform () {
    this._initialize()
    this._addToRelationship()
  }

  _initialize () {
    if (!this.parent.relationships) this.parent.relationships = {}
    if (!this._relationship()) this.parent.relationships[this.relationshipName] = {}
    if (!this._relationshipData()) this._relationship().data = []
  }
  _addToRelationship () {
    this._relationshipData().push(this._associatedEntry())
  }

  _relationship () {
    return this.parent.relationships[this.relationshipName]
  }
  _relationshipData () {
    return this._relationship().data
  }
  _associatedEntry () {
    return { id: this.child.id, type: this.child.type }
  }
}
