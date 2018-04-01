import Vue from 'vue/dist/vue.common'

import VueResource from 'vue-resource'

Vue.use(VueResource)

export default {
  initEntry (context, url) {
    if (context.getters.wasUrlCalled(url)) {
      return context.getters.getPromiseByUrl(url)
        .then(request => request.data)
    }
    return context.dispatch('add', { url })
  },
  initRelatedEntry (context, { entry, name }) {
    if (!entry.relationships || !entry.relationships[name] ||
        !entry.relationships[name].data) {
      return new Promise(resolve => resolve(null))
    }

    let relatedEntryReference = entry.relationships[name].data

    if (context.getters.getAssociatedEntry({ entry, name })) {
      return context.getters.getAssociatedEntry({ entry, name })
    }
    return context.dispatch('add',
      relatedEntryReference.links.url)
  },
  initRelatedCollection (context, { entry, name }) {
    let relatedEntriesReference = entry.relationships[name].data

    if (context.getters.getAssociatedEntries({ entry, name }) !== []) {
      return new Promise((resolve, reject) => {
        resolve(context.getters.getAssociatedEntries({ entry, name }))
      })
    }
    return context.dispatch('addCollection',
      relatedEntriesReference.links.url)
  },
  add (context, { endpoint, resource, url }) {
    if (!url && endpoint && !resource) {
      resource = url.replace(endpoint, '')
    }
    url = url || `${endpoint}/${resource}`

    return context.dispatch('request', { url }).then(response => {
      context.commit('addByNormalize', {
        payload: response, endpoint
      })
      return response.data
    })
  },
  request (context, { url, method, payload }) {
    let promise = Vue.http[method || 'get'](url, { data: payload }).then(
      response => {
        return response.data
      },
      response => {
        alert(JSON.stringify(response.data))
      })

    context.commit('addCalledUrl', { url, promise })

    return promise
  },
  destroy (context, entry, url) {
    return context.dispatch('request', {
      url: url || entry.links.self,
      method: 'delete'
    })
  },
  update (context, { entry, payload, url, delayed }) {
    if (!delayed) context.commit('update', { entry, payload })

    return context.dispatch('request', {
      url: url || entry.links.self,
      method: 'patch',
      payload
    }).then(response => {
      if (delayed) context.commit('update', { entry, payload })
      if (response.data) context.commit('update', { entry, payload: response.data })
    })
  },
  create (context, { url, payload }) {
    return new Promise(resolve => {
      context.dispatch('request', { url, method: 'post', payload }).then(
        response => {
          context.commit('add', response.data)
          resolve(response.data)
        })
    })
  },
  changeOneToManyReference (context, { child, parent,
    parentRelationshipName, childRelationshipName }) {
    context.dispatch('changeRelationship', {
      child,
      parent,
      parentRelationshipName,
      childRelationshipName,
      url: child.links.self,
      data: { id: parent.id, type: parent.type }
    })
  },
  changeManyToOneReference (context, { children, parent,
    parentRelationshipName, childRelationshipName }) {
    context.commit('changeManyToOneReference', {
      children: children.map((child) => context.getters.get(child)),
      parent,
      parentTypes: ['board-lists'],
      parentRelationshipName,
      childRelationshipName
    })
    return context.dispatch('update', {
      entry:
      parent,
      payload: {
        id: parent.id,
        type: parent.type,
        relationships: {
          [parentRelationshipName]: { data: children }
        }
      }
    })
  },
  changeRelationship (context, { url, child, parent,
    parentRelationshipName, childRelationshipName, data }) {
    return context.dispatch('request', {
      url,
      method: 'put',
      payload: { relationships: {
        [childRelationshipName]: { data: data }
      }}
    }).then(response => {
      context.commit('removeFromAll', {
        child: child,
        parentType: parent.type,
        parentRelationshipName: parentRelationshipName
      })
      context.commit('addToMultiple', {
        parent, child, relationshipName: parentRelationshipName })
      context.commit('setAssociation', {
        parent, child, relationshipName: childRelationshipName
      })
      return undefined
    })
  }
}
