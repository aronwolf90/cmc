<template lang='pug'>
  .contacts-index
    index-top-section(
      resource="contacts",
      new-text="New contact",
      :item-text-function="itemTextFunction"
    )

    br
    br

    ul.list-group.list-lines
      index-list-item(
        v-for="contact in contacts",
        resource="contacts",
        :entry-type="contact.type",
        :entry-id="contact.id",
        :text="contact.attributes.name",
        :editBtn="true"
      )
</template>

<script>
import IndexTopSection from '../components/index-top-section'
import IndexListItem from '../components/index-list-item'

export default {
  components: {
    IndexTopSection,
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
  },
  methods: {
    itemTextFunction(contact) {
      return contact.attributes.name
    }
  }
}
</script>
