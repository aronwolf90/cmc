import Vue from 'vue/dist/vue.common'

export default class {
  constructor ({ state, exclude }) {
    this.state = state
    this.exclude = exclude
  }
  perform () {
    for (let key of Object.keys(this.state)) {
      if (key === 'config') continue
      Vue.delete(this.state, key)
    }
  }
}
