import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor(state, entry) {
    this.state = state
    this.entry = entry
  }
  perform() {
    this._collection().splice(this._index(), 1)
  }

  _type() {
    return Utils.underscore(this.entry.type)
  }
  _collection() {
    return this.state[this._type()]
  }
  _index() {
    return this._collection().findIndex(local_entry => local_entry.id == this.entry.id)
  }
}
