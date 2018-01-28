import Vue from 'vue/dist/vue.common'

import * as Utils from './utils'

import AddService from './services/mutations/add_service'
import UpdateService from './services/mutations/update_service'
import RemoveService from './services/mutations/remove_service'
import RemoveFromAllService from './services/mutations/remove_from_all_service'
import AddToMultipleService from './services/mutations/add_to_multiple_service'
import SetAssociationService from './services/mutations/set_association_service'

export default {
  init(state, type) {
    Utils.init(state, type)
  },
  add(state, payload) {
    new AddService(state, payload).perform()
  },
  update(state, { entry, payload }) {
    new UpdateService(entry, payload).perform()
  },
  remove(state, entry) {
    new RemoveService(state, entry).perform()
  },
  removeFromAll(state, { child, parent_type, parent_relationship_name }) {
    new RemoveFromAllService(state, child, parent_type, parent_relationship_name).perform()
  },
  addToMultiple(state, { parent, child, relationship_name }) {
    new AddToMultipleService(state, parent, child, relationship_name).perform()
  },
  setAssociation(state, { child, parent, relationship_name }) {
    new SetAssociationService(state, parent, child, relationship_name).perform()
  },
  clear(state) {
    for (let key of Object.keys(state)) {
      delete state[key]
    }
  }
}
