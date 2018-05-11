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
    this._init(this.state, 'meta', { })
    let metaData = this._normalizedPayload().meta

    if (!metaData) return

    for (let resource of Object.keys(metaData)) {
      let data = null
      if (Array.isArray(this.payload.data)) {
        data = Utils.entryArrayToRef(metaData[resource].data)
      } else {
        data = Utils.entryToRef(metaData[resource].data[0])
      }
      Vue.set(this.state.meta, resource, { data, info: this._info() })
    }
  }

  _addCollection (key) {
    let source = this._normalizedPayload()

    this._init(this.state, key, {})
    for (const [entryId, entry] of Object.entries(source[key])) {
      Vue.set(this.state[key], entryId, entry)
    }
  }
  _init (state, key, value) {
    if (state[key]) return
    Vue.set(state, key, value)
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
  _info () {
    let queryString = this.resource.replace(new RegExp('^[^?]*.'), '')
    let keyValuePairs = queryString.split('&')
    let result = {}

    if (!queryString) return

    for (const keyValuePair of keyValuePairs) {
      let key = keyValuePair.split('=')[0]
      let value = keyValuePair.split('=')[1]
      let match = key.match(/([a-zA-Z0-9]*)\[([a-zA-Z0-9_]*)\]/)

      if (match.length === 3) {
        if (match[2] === '') {
          if (!result[match[1]]) result[match[1]] = []
          result[match[1]].push(value)
        } else {
          result[match[1]] = value.split(',')
        }
      } else {
        result[key] = value
      }
    }
    return result
  }
}
