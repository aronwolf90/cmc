import Vue from 'vue/dist/vue.common'

import VueResource from 'vue-resource'
import PQueue from 'p-queue'

Vue.use(VueResource)

const queue = new PQueue({concurrency: 1})

const required = (params) => {
  for (const [paramsName, paramValue] of Object.entries(params)) {
    if (paramValue) continue
    throw new Error(`${paramsName} is required`)
  }
}

const calculeUrl = ({ endpoint, resource, url }) => {
  if (!url && endpoint && !resource) {
    resource = url.replace(endpoint, '')
  }
  return (!resource && url) || `${endpoint}/${resource}`
}

export default {
  initEntry (context, { endpoint, resource }) {
    required({ endpoint, resource })
    let url = calculeUrl({ endpoint, resource })

    if (context.getters.wasUrlCalled(url)) {
      return context.getters.urlPromise(url)
        .then(request => request.data)
    }
    return context.dispatch('add', { endpoint, resource, url })
  },
  initRelatedEntry (context, { entry, name }) {
    required({ entry, name })

    if (!entry.relationships || !entry.relationships[name] ||
        !entry.relationships[name].data) {
      return new Promise(resolve => resolve(null))
    }

    let relatedEntryReference = entry.relationships[name].data

    if (context.getters.associatedEntry({ entry, name })) {
      return context.getters.associatedEntry({ entry, name })
    }
    return context.dispatch('add',
      relatedEntryReference.links.url)
  },
  initRelatedCollection (context, { entry, name }) {
    required({ entry, name })

    let relatedEntriesReference = entry.relationships[name].data

    if (context.getters.associatedEntries({ entry, name }) !== []) {
      return new Promise((resolve, reject) => {
        resolve(context.getters.associatedEntries({ entry, name }))
      })
    }
    return context.dispatch('addCollection',
      relatedEntriesReference.links.url)
  },
  add (context, { endpoint, resource, url }) {
    required({ endpoint, resource })
    url = calculeUrl({ endpoint, resource, url })

    return context.dispatch('request', { url }).then(response => {
      context.commit('addByNormalize', {
        payload: response, resource
      })
      return response.data
    })
  },
  request (context, { url, method, payload }) {
    required({ url })

    let promise = null
    if (method === 'get' || !method) {
      promise = Vue.http['get'](url, { data: payload }).then(
        response => {
          return response.data
        },
        response => {
          alert(JSON.stringify(response.data))
        })
    } else {
      promise = queue.add(() => {
        return Vue.http[method](url, { data: payload }).then(
          response => {
            return response.data
          },
          response => {
            alert(JSON.stringify(response.data))
          })
      })
    }

    context.commit('addCalledUrl', { url, promise })

    return promise
  },
  destroy (context, { entry, endpoint, resource }) {
    required({ entry, endpoint })
    let url = calculeUrl({ endpoint, resource, url: entry.links.self })

    context.commit('remove', entry)
    return context.dispatch('request', { url, method: 'delete' })
  },
  update (context, { entry, payload, endpoint, resource, delayed }) {
    required({ entry, payload, endpoint })
    let url = calculeUrl({ endpoint, resource, url: entry.links.self })

    if (!delayed) context.commit('update', { entry, payload })

    return context
      .dispatch('request', { url, method: 'patch', payload })
      .then(response => {
        if (delayed) context.commit('update', { entry, payload })
        if (response.data) context.commit('update', { entry, payload: response.data })
      })
  },
  create (context, { payload, endpoint, resource }) {
    required({ payload, endpoint, resource })
    let url = calculeUrl({ endpoint, resource })

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
    required({ child, parent, parentRelationshipName, childRelationshipName })

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
    parentRelationshipName, childRelationshipName, endpoint, parentTypes }) {
    required({ children, parent, parentRelationshipName, childRelationshipName, endpoint })

    context.commit('changeManyToOneReference', {
      children, parent, parentTypes, parentRelationshipName, childRelationshipName
    })
    return context.dispatch('update', {
      entry: parent,
      endpoint,
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
