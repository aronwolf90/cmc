import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor ({ state, entry }) {
    this.state = state
    this.entry = entry
  }
  perform () {
    this._removeFromCollection()
    this._removeFromMeta()
  }

  _removeFromCollection () {
    Vue.delete(this._collection(), this.entry.id)
  }
  _removeFromMeta () {
    for (const [resource, data] of Object.entries(this.state.meta)) {
      if (Array.isArray(data)) {
        Vue.set(this.state.meta, resource, this._filterMetaCollection(data))
      }
      if (this._shouldDelete(data)) Vue.delete(this.state.meta, resource)
    }
  }

  _collection () {
    return this.state[this.entry.type]
  }
  _filterMetaCollection (data) {
    return data.filter(entry => !Utils.sameRef(entry, this.entry))
  }
  _shouldDelete (data) {
    return data.length === 0 || Utils.sameRef(data, this.entry)
  }
}
