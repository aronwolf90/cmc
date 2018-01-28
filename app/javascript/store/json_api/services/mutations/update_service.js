import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor(entry, payload) {
    this.entry = entry
    this.payload = payload
  }
  perform() {
    if (this.payload.attributes) this._update_attributes()
    if (this.payload.links) this._update_links()
  }

  _update_attributes() {
    if (!this.entry.attributes) Vue.set(this.entry, 'attributes', {})

    let attributes = this.entry.attributes

    for (let key of Object.keys(this.payload.attributes)) {
      Vue.set(attributes, key, this.payload.attributes[key])
    }
  }
  _update_links() {
    if (!this.entry.links) this.entry.links = []

    let links = this.entry.links

    for (let key of Object.keys(this.payload.links)) {
      links[key] = this.payload.links[key]
    }
  }
}
