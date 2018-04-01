import Vue from 'vue/dist/vue.common'

export const init = (state, type) => {
  if (state[type]) return
  Vue.set(state, type, [])
}

export const get = (state, type, id) => {
  if (!state[type]) return
  return state[type][id]
}

export const getCollection = (state, type) => {
  if (!state[type]) return
  return Object.values(state[type])
}

export const clearFromCollection = (state, entry,
  type, relationshipName) => {
  for (let collectionEntry of getCollection(state, type)) {
    if (!collectionEntry.relationships) continue
    if (!collectionEntry.relationships[relationshipName]) continue

    let relationship = collectionEntry.relationships[relationshipName].data
    let index = relationship.findIndex((refEntry) => {
      return refEntry.id === entry.id && refEntry.type === entry.type
    })
    if (index > -1) relationship.splice(index, 1)
  }
}

export const entryToRef = (entry) => {
  return { id: entry.id, type: entry.type }
}

export const sameRef = (entry1, entry2) => {
  return entry1.type === entry2.type &&
    entry1.id === entry2.id
}

export const entryArrayToRef = (entryArray) => {
  return entryArray.map(entry => entryToRef(entry))
}

export const initRelationshipCollection = (entry, relationshipName) => {
  if (!entry.relationships) Vue.set(entry, 'relationships', {})
  if (!entry.relationships[relationshipName]) {
    Vue.set(entry.relationships, relationshipName, {})
  }
  if (!entry.relationships[relationshipName].data) {
    Vue.set(entry.relationships[relationshipName], 'data', [])
  }
}

export const setRelationshipEntry = (entry, relationshipName,
  associatedEntry) => {
  if (!entry.relationships) Vue.set(entry, 'relationships', {})
  if (!entry.relationships[relationshipName]) {
    Vue.set(entry.relationships, relationshipName, {})
  }
  if (!entry.relationships[relationshipName].data) {
    Vue.set(entry.relationships[relationshipName], 'data', associatedEntry)
  }
}
