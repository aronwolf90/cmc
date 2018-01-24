import Vue from 'vue/dist/vue.common'

import * as Utils from './utils'

import InitService from './services/mutations/init_service'
import AddService from './services/mutations/add_service'
import UpdateService from './services/mutations/update_service'
import RemoveService from './services/mutations/remove_service'
import RemoveFromAllService from './services/mutations/remove_from_all_service'
import AddToMultipleService from './services/mutations/add_to_multiple_service'
import SetAssotiationService from './services/mutations/set_assotiation_service'

export default {
  init(state, type) {
    new InitService(state, type).perform()
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
  removeFromAll(state, { child, parent, parent_relationship_name }) {
    new RemoveFromAllService(state, child, parent, parent_relationship_name).perform()
  },
  addToMultiple(state, { parent, child, relationship_name }) {
    new AddToMultipleService(state, parent, child, relationship_name).perform()
  },
  setAssotiation(state, { child, parent, relationship_name }) {
    new SetAssotiationService(state, parent, child, relationship_name).perform()
  },
  clear(state) {
    for (let key of Object.keys(state)) {
      delete state[key]
    }
  }
}
