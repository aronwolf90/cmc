import Vue from 'vue/dist/vue.common'

import AddService from './services/mutations/add_service'
import AddByNormalizeService from './services/mutations/add_by_normalize_service'
import UpdateService from './services/mutations/update_service'
import RemoveService from './services/mutations/remove_service'
import RemoveFromAllService from './services/mutations/remove_from_all_service'
import AddToMultipleService from './services/mutations/add_to_multiple_service'
import SetAssociationService from './services/mutations/set_association_service'
import ChangeManyToOneReferenceService from './services/mutations/change_many_to_one_reference_service'
import ClearService from './services/mutations/clear_service'

import * as Utils from './utils'

export default {
  add (state, payload) {
    new AddService({ state, payload }).perform()
  },
  update (state, { entry, payload }) {
    new UpdateService({ entry, payload }).perform()
  },
  remove (state, entry) {
    new RemoveService({state, entry}).perform()
  },
  removeFromAll (state, { child, parentType, parentRelationshipName }) {
    new RemoveFromAllService({ state, child, parentType, parentRelationshipName }).perform()
  },
  addToMultiple (state, { parent, child, relationshipName }) {
    new AddToMultipleService({ parent, child, relationshipName }).perform()
  },
  setAssociation (state, { child, parent, relationshipName }) {
    new SetAssociationService({ parent, child, relationshipName }).perform()
  },
  clear (state, { exclude }) {
    new ClearService({ exclude }).perform()
  },
  clearCalledUrls (state) {
    if (!state['called_urls']) return
    Vue.delete(state, 'called_urls')
  },
  addCalledUrl (state, { url, promise }) {
    if (!state['called-urls']) Vue.set(state, 'called-urls', {})
    Vue.set(state['called-urls'], url, promise)
  },
  changeManyToOneReference (state, { children, parent, parentTypes,
    parentRelationshipName, childRelationshipName }) {
    new ChangeManyToOneReferenceService({
      state,
      children,
      parent,
      parentTypes,
      parentRelationshipName,
      childRelationshipName
    }).perform()
  },
  addByNormalize (state, { payload, resource }) {
    new AddByNormalizeService({ state, payload, resource }).perform()
  },
  changeMetaCollection (state, { name, collection }) {
    state.meta[name].data = Utils.entryArrayToRef(collection)
  },
  setEndpoint (state, endpoint) {
    state.endpoint = endpoint
  }
}
