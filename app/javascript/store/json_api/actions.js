import Vue from 'vue/dist/vue.common'

import VueResource from 'vue-resource'
import * as Utils from './utils'

Vue.use(VueResource)

export default {
  initEntry(context, { url, id, type }) {
    if (context.getters.get({ type, id })) return
    context.dispatch('add', url)
  },
  initCollection(context, { url, type }) {
    console.log(type)
    if (context.getters.getCollection(type)) return
    context.dispatch('addCollection', url)
    if (!context.getters.getCollection(type)) context.commit('init', type)
  },
  add(context, url) {
    context.dispatch('request', { url, success_funtion: (response) => {
      context.commit('add', response.data.data)
      for (let entry of response.data.included || []) {
        context.commit('add', entry)
      }
    }})
  },
  addCollection(context, url) {
    context.dispatch('request', { url, success_funtion: (response) => {
      for (let entry of response.data.data) {
        context.commit('add', entry)
      }
      for (let entry of response.data.included || []) {
        context.commit('add', entry)
      }
    }})
  },
  request(context, { url, success_funtion}) {
    Vue.http.get(url).then(response => {
      success_funtion(response)
    }, response => {
      alert(response)
    })
  },
  update(context, { entity, payload, func_success }) {
    Vue.http.put(entity.links.self, payload)
      .then(response => {
        context.commit('update', { entity, payload })
        if (func_success) func_success()
      }, response => {
        alert(response)
      })
  },
  create(context, { url, payload, func_success }) {
    Vue.http.post(url, payload )
      .then(response => {
        context.commit('add', response.data)
        if (func_success) func_success()
      }, response => {
        alert(response)
      })
  },
  destroy(context, entry, func_success) {
    Vue.http.delete(entry.links.self)
      .then(response => {
        context.commit('destroy', entry)
        if (func_success) func_success()
      }, response => {
        alert(response)
      })
  }
}
