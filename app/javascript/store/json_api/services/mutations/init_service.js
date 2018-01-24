import Vue from 'vue/dist/vue.common'
import * as Utils from '../../utils'

export default class {
  constructor(state, collection_name) {
    this.state =  state
    this.collection_name = collection_name
  }
  perform() {
    if (this._collection()) return

    Vue.set(this.state, this.collection_name, [])
  }
  _collection() {
    return this.state[this.collection_name]
  }
}
