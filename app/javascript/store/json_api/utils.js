import Vue from 'vue/dist/vue.common'

export const underscore = (type) => {
  if (!type) return ""
  return type.replace('-', '_')
}

export const init = (state, type) => {
  if (state[type]) return
  Vue.set(state, type, [])
}

export const get = (state, type, id) => {
  if (!getCollection(state, type)) return
  return getCollection(state, type).find(entry => entry.id == id)
}

export const getCollection = (state, type) => {
  return state[underscore(type)]
}

export const clearFromCollection = (state, entry,
  type, relationship_name) => {

  for (let collection_entry of getCollection(state, type)) {
    if (!collection_entry.relationships) continue
    if (!collection_entry.relationships[relationship_name]) continue

    let relationship = collection_entry.relationships[relationship_name].data
    let index = relationship.findIndex((ref_entry) => {
      return ref_entry.id == entry.id && ref_entry.type == entry.type
    })
    if (index > -1) relationship.splice(index, 1)
  }
}

export const entryToRef = (entry) => {
  return { id: entry.id, type: entry.type }
}

export const initRelationshipCollection = (entry, relationship_name) => {
  if (!entry.relationships) Vue.set(entry, "relationships", {})
  if (!entry.relationships[relationship_name]) {
    Vue.set(entry.relationships, relationship_name, {})
  }
  if (!entry.relationships[relationship_name].data) {
    Vue.set(entry.relationships[relationship_name], "data", [])
  }
}

export const setRelationshipEntry = (entry, relationship_name,
  associated_entry) => {

  if (!entry.relationships) Vue.set(entry, "relationships", {})
  if (!entry.relationships[relationship_name]) {
    Vue.set(entry.relationships, relationship_name, {})
  }
  if (!entry.relationships[relationship_name].data) {
    Vue.set(entry.relationships[relationship_name], "data", associated_entry)
  }
}
