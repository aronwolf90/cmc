import Vue from 'vue/dist/vue.common'

import VueResource from 'vue-resource'
import * as Utils from './utils'

Vue.use(VueResource)

export default {
  initEntry(context, url) {
    if (context.getters.wasUrlCalled(url)) {
      return context.getters.getPromiseByUrl(url)
		    .then(request => request.data)
    }
    return context.dispatch('add', url)
  },
  initCollection(context, url) {
    if (context.getters.wasUrlCalled(url)) {
      return context.getters.getPromiseByUrl(url)
	            .then(request => request.data)
    }
    return context.dispatch('addCollection', url)
  },
  initRelatedEntry(context, { entry, name }) {
    if (!entry.relationships || !entry.relationships[name] ||
        !entry.relationships[name].data) {
      return new Promise(resolve => resolve(null)  )
    }

    let related_entry_reference = entry.relationships[name].data

    if (context.getters.getAssociatedEntry({ entry, name })) {
      return context.getters.getAssociatedEntry({ entry, name })
    }
    return context.dispatch('add',
	     related_entry_reference.links.url)
  },
  initRelatedCollection(context, { entry, name }) {
    let related_entries_reference = entry.relationships[name].data

    if (context.getters.getAssociatedEntries({ entry, name }) != []) {
      return new Promise((resolve, reject) => {
        resolve(context.getters.getAssociatedEntries({ entry, name }))
      })
    }
    return context.dispatch('addCollection',
	     related_entries_reference.links.url)
  },
  add(context, url) {
    return context.dispatch('request', { url }).then(response => {
      context.commit('add', response.data)
      for (let entry of response.included || []) {
        context.commit('add', entry)
      }
      return response.data
    })
  },
  addCollection(context, url) {
    return context.dispatch('request', { url }).then((response) => {
      for (let entry of response.data) {
        context.commit('add', entry)
      }
      for (let entry of response.included || []) {
        context.commit('add', entry)
      }
      return response.data
    })
  },
  request(context, { url, method, payload }) {
    let promise = Vue.http[method || 'get'](url, { data: payload }).then(
      response => {
         return response.data
      },
      response => {
        alert(JSON.stringify(response.data))
      })

    context.commit("addCalledUrl", { url, promise })

    return promise
  },
  destroy(context, entry, url) {
    return context.dispatch("request", {
      url: url || entry.links.self,
      method: "delete"
    } )
  },
  update(context, { entry, payload, url }) {
    return context.dispatch("request", {
      url: url || entry.links.self,
      method: "put",
      payload
    } )
  },
  create(context, { url, payload, func_success }) {
    return new Promise((success) => {
      context.dispatch('request', { url, method: 'post', payload }).then(
      response => {
        context.commit('add', response.data)
        success(response.data)
      })
    })
  },
  changeOneToManyReference(context, { child, parent,
    parent_relationship_name, child_relationship_name }) {

    context.dispatch('changeRelationship', {
      child, parent,
      parent_relationship_name,
      child_relationship_name,
      func_success,
      url: child.links.self,
      data: { id: parent.id, type: parent.type }
    })
  },
  changeRelationship(context, { url, child, parent,
    parent_relationship_name, child_relationship_name, data }) {

    let local_data = { data: { relationships: { }}}
    local_data.data.relationships[child_relationship_name] = { data }

    let params = {
      url,
      method: "put",
      payload: local_data
    }
    context.dispatch('request', params).then(
    response => {
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
    })
  }
}
