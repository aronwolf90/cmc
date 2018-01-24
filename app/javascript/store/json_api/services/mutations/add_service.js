import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor(state, payload) {
    this.state = state
    this.payload = payload
  }
  perform() {
    this._init()
    this._add()
  }

  _init() {
    Utils.init(this.state, this._type())
  }
  _add() {
    if (this._is_present()) return

    this._collection().push(this.payload)
  }

  _type() {
    return Utils.underscore(this.payload.type)
  }
  _collection() {
    return this.state[this._type()]
  }

  _is_present() {
    return Utils.get(this.state, {
      type: this._type(),
      id: this.payload.id
    }) != undefined
  }
}
