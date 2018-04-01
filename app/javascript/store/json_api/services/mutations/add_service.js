import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor ({ state, payload }) {
    this.state = state
    this.payload = payload
  }
  perform () {
    this._init()
    this._add()
  }

  _init () {
    Utils.init(this.state, this._type())
  }
  _add () {
    if (this._isPresent()) return

    Vue.set(this._collection(), this.payload.id, this.payload)
  }

  _type () {
    return this.payload.type
  }
  _collection () {
    return this.state[this._type()]
  }

  _isPresent () {
    return Utils.get(this.state, this._type(),
      this.payload.id) !== undefined
  }
}
