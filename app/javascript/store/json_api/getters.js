import Vue from 'vue/dist/vue.common'
import * as Utils from './utils'

export default {
  get(state) {
    return ({type, id}) => {
      return Utils.get(state, type, id)
    }
  },
  getAll(state) {
    return (type) => {
      return Utils.getCollection(state, type) || []
    }
  },
  getCollection(state) {
    return (type) => {
      return Utils.getCollection(state, type)
    }
  },
  getAssociatedEntries(state) {
    return ({entry, name}) => {
      if (!entry) return []
      if (!entry.relationships) return []
      if (!entry.relationships[name]) return []
      if (!entry.relationships[name].data) return []

      return entry.relationships[name].data.map(local_entry => {
        entries = Utils.get(state, Utils.underscore(local_entry.type), local_entry.id)
        if (entries.includes(null)) return []
        else return entries
      })
    }
  },
  getAssociatedEntry(state) {
    return ({entry, name}) => {
      if (!entry) return
      if (!entry.relationships) return
      if (!entry.relationships[name]) return
      if (!entry.relationships[name].data) return

      let associated = entry.relationships[name].data
      if (!entry.relationships || !entry.relationships[name]) return
      return Utils.get(state, Utils.underscore(associated.type), associated.id)
    }
  },
  wasUrlCalled(state) {
    return (url) => {
      if (!state["called_urls"]) return
      return state["called_urls"][url] != undefined
    }
  },
  getPromiseByUrl(state) {
    return (url) => {
      return state["called_urls"][url]
    }
  }
}
