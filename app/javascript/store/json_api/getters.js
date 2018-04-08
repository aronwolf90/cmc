import * as Utils from './utils'

import MetaEntryService from './services/getters/meta_entry_service'
import MetaInfoService from './services/getters/meta_info_service'
import MetaCollectionService from './services/getters/meta_collection_service'
import AssociatedEntriesService from './services/getters/associated_entries_service'
import AssociatedEntryService from './services/getters/associated_entry_service'

export default {
  entry (state) {
    return ({type, id}) => Utils.get(state, { type, id })
  },
  collection (state) {
    return (type) => Utils.getCollection(state, type)
  },
  metaEntry (state) {
    return (name) => new MetaEntryService({ state, name }).perform()
  },
  metaInfo (state) {
    return (name) => new MetaInfoService({ state, name }).perform()
  },
  metaCollection (state) {
    return (name) => new MetaCollectionService({ state, name }).perform()
  },
  associatedEntries (state) {
    return ({entry, name}) => new AssociatedEntriesService({state, entry, name}).perform()
  },
  associatedEntry (state) {
    return ({entry, name}) => new AssociatedEntryService({state, entry, name}).perform()
  },
  wasUrlCalled (state) {
    return (url) => {
      if (!state['called-urls']) return false
      return state['called-urls'][url] !== undefined
    }
  },
  urlPromise (state) {
    return (url) => {
      if (!state['called-urls']) return
      return state['called-urls'][url]
    }
  }
}
