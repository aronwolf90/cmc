import Vue from 'vue/dist/vue.common'

export default class {
  constructor ({ entry, payload }) {
    this.entry = entry
    this.payload = payload
  }
  perform () {
    if (this.payload.attributes) this._updateAttributes()
    if (this.payload.relationships) this._updateRelationships()
  }

  _updateAttributes () {
    if (!this.entry.attributes) Vue.set(this.entry, 'attributes', {})

    let attributes = this.entry.attributes

    for (let key of Object.keys(this.payload.attributes)) {
      Vue.set(attributes, key, this.payload.attributes[key])
    }
  }
  _updateRelationships () {
    if (!this.entry.relationships) this.entry.relationships = []

    let relationships = this.entry.relationships

    for (let key of Object.keys(this.payload.relationships)) {
      relationships[key] = this.payload.relationships[key]
    }
  }
}
