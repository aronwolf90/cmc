import Vue from 'vue/dist/vue.common'
import normalize from 'json-api-normalizer'
import * as Utils from './../../utils'

export default class {
  constructor ({ state, payload, resource }) {
    this.state = state
    this.payload = payload
    this.resource = resource
  }
  perform () {
    this._addCollections()
    this._addMetaResource()
  }

  _addCollections () {
    for (let key of Object.keys(this._normalizedPayload())) {
      if (key !== 'meta') this._addCollection(key)
    }
  }
  _addMetaResource () {
    this._init(this.state, 'meta')
    let metaData = this._normalizedPayload().meta

    if (!metaData) return

    for (let resource of Object.keys(metaData)) {
      if (Array.isArray(this.payload.data)) {
        Vue.set(this.state.meta, resource, Utils.entryArrayToRef(metaData[resource].data))
      } else {
        Vue.set(this.state.meta, resource, Utils.entryToRef(metaData[resource].data[0]))
      }
    }
  }

  _addCollection (key) {
    let source = this._normalizedPayload()

    this._init(this.state, key)
    for (const [entryId, entry] of Object.entries(source[key])) {
      Vue.set(this.state[key], entryId, entry)
    }
  }
  _init (state, key) {
    if (state[key]) return
    Vue.set(state, key, {})
  }

  _normalizedPayload () {
    if (!this._normalizedPayloadVar) {
      this._normalizePayloadVar =
        normalize(this.payload, {
          endpoint: this.resource,
          camelizeTypeValues: false,
          camelizeKeys: false
        })
    }

    return this._normalizePayloadVar
  }
}
