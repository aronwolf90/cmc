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
      context.commit('add', response.data)
      for (let entry of response.included || []) {
        context.commit('add', entry)
      }
    }})
  },
  addCollection(context, url) {
    context.dispatch('request', { url, success_funtion: (response) => {
      for (let entry of response.data) {
        context.commit('add', entry)
      }
      for (let entry of response.included || []) {
        context.commit('add', entry)
      }
    }})
  },
  request(context, { url, method, payload, success_funtion }) {
    let test = eval(Vue.http, `${method || 'get'}`)(url)

    Vue.http[method || 'get'](url, payload).then(response => {
      success_funtion(response.data)
    }, response => {
      alert(JSON.stringify(response.data))
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
  },
  update(context, { entry, payload, func_success }) {
    Vue.http.put(entry.links.self, { data: payload })
      .then(response => {
        context.commit('update', { entry, payload })
        if (func_success) func_success()
      }, response => {
        alert(response)
      })
  },
  create(context, { url, payload, func_success }) {
    context.dispatch('request', { url, method: 'post', payload, success_funtion: (response)=> {
      context.commit('add', response.data)
      if (func_success) {
        func_success(context.getters.get({
          type: response.data.type,
          id: response.data.id
        }))
      }
    }})
  },
  destroy(context, entry, func_success) {
    Vue.http.delete(entry.links.self)
      .then(response => {
        context.commit('destroy', entry)
        if (func_success) func_success()
      }, response => {
        alert(response)
      })
  },
  changeOneToManyReference(context, { child, parent, parent_relationship_name, child_relationship_name, func_success }) {
    context.dispatch('changeRelationship', {
      child, parent,
      parent_relationship_name,
      child_relationship_name,
      func_success,
      url: child.links.self,
      data: { id: parent.id, type: parent.type }
    })
  },
  changeRelationship(context, { url, child, parent, parent_relationship_name, child_relationship_name, data, func_success }) {
    let local_data = { data: { relationships: { }}}
    local_data.data.relationships[child_relationship_name] = { data }

    context.dispatch('request', { url, method: 'put', payload: local_data, success_funtion: (response) => {
      context.commit('removeFromAll', {
        child: child,
        parent_type: parent.type,
        parent_relationship_name: parent_relationship_name
      })
      context.commit('addToMultiple', {
        parent: parent,
        child: child,
        relationship_name: parent_relationship_name })
      context.commit('setAssociation', {
        parent: parent,
        child: child,
        relationship_name: child_relationship_name
      })
      if (func_success) func_success()
    }})
  }
}
