<template lang='pug'>
  .contacts-index
    .d-flex.flex-row
      .w-100.mr-2
        index-search-section(
          search-endpoint='/api/v1/contacts',
          attribute='name'
        )
      a.btn.btn-success(href='/administration/contacts/new')
        | New contact
    
    br
    br
    
    ul.list-group.list-lines
      index-list-item(
        v-for="contact in contacts",
        base-path="/administration/contacts",
        :entry-type="contact.type",
        :entry-id="contact.id",
        :text="contact.attributes.name"
      )
</template>

<script>
import IndexSearchSection from '../components/index-search-section'
import IndexListItem from '../components/index-list-item'

export default {
  components: {
    IndexSearchSection,
    IndexListItem
  },
  asyncComputed: {
    result () {
      return this.$store.dispatch('getContacts')
    }
  },
  computed: {
    contacts () {
      if (!this.result) return []
      return this.result.data
    },
    apiLinks () {
      if (!this.result) return
      return this.result.links
    }
  }
}
</script>
