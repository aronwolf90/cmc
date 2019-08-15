<template lang='pug'>
  .users-index
    index-top-section(
      resource="users",
      new-text="New user",
      :item-text-function="itemTextFunction",
    )

    br
    br
    
    ul.list-group.list-lines
      index-list-item(
        v-for="user in users",
        resource="users",
        :entry-type="user.type",
        :entry-id="user.id",
        :text="itemTextFunction(user)"
      )
</template>

<script>
import IndexTopSection from '../components/index-top-section'
import IndexListItem from '../components/index-list-item'
import IndexSearchSectionItem from '../components/index-list-item' 

export default {
  components: {
    IndexTopSection,
    IndexListItem,
    IndexSearchSectionItem
  },
  asyncComputed: {
    result () {
      return this.$store.dispatch('users')
    }
  },
  computed: {
    users () {
      if (!this.result) return []
      return this.result.data
    }
  },
  methods: {
    itemTextFunction(user) {
      return `${user.attributes.firstname} ${user.attributes.lastname}`
    }
  }
}
</script>
