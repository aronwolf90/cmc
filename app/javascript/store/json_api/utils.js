export const get = (state, { type, id }) => {
  if (!state[type]) return
  return state[type][id]
}

export const getCollection = (state, type) => {
  if (!state[type]) return
  return Object.values(state[type])
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

export const attribute = (entry, name) => {
  if (!entry) return
  if (!entry.attributes) return
  return entry.attributes[name]
}
