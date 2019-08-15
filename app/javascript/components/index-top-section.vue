<template lang='pug'>
  .d-flex.flex-row
    .w-100.mr-2
      index-search-section(:resource="resource")
        template(v-slot:default="slotProps")
          slot(v-bind:entry="slotProps.entry")
            index-search-section-item(
              :text="itemTextFunction(slotProps.entry)",
              :link="`/administration/${resource}/${slotProps.entry.id}`"
            )
    a.btn.btn-success(:href="`/administration/${resource}/new`")
      | {{ newText }}
</template>

<script>
import IndexSearchSection from './index-search-section'
import IndexSearchSectionItem from './index-search-section-item'

export default {
  components: {
    IndexSearchSection,
    IndexSearchSectionItem
  },
  data () {
    return { 
      searchText: '', 
      focused: false
    }
  },
  props: [
    "resource",
    "itemTextFunction",
    "newText"
  ]
}
</script>
