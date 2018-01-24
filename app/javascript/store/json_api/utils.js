import Vue from 'vue/dist/vue.common'

export const underscore = (type) => {
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
  return state[type]
}
