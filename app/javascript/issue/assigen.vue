<template lang='pug'>
  div
    label Assignment
    basic-select(
      :options="options",
      :selected-option="item",
      placeholder="select item",
      @select="onSelect"
    )
    hr.divider
</template>

<script>
import { BasicSelect } from 'vue-search-select'

export default {
  props: ['issue_id'],
  data () {
    return {
      searchText: ''
    }
  },
  created () {
    this.$store.dispatch('initUsers')
  },
  computed: {
    options () {
      this.$store.getters.test
      return this.$store.getters.getAll('users').map((user) => {
        return {
          value: user.id,
          text: user.attributes.firstname
        }
      })
    },
    issue () {
      return this.$store.getters.get({
        type: 'issues',
        id: this.issue_id
      })
    },
    user () {
      return this.$store.getters.getAssociatedEntry({
        entry: this.issue,
        name: 'user'
      })
    },
    item: {
      get () {
        if (!this.user) return
        return {
          value: this.user.id,
          text: this.user.attributes.firstname
        }
      }
    }
  },
  methods: {
    onSelect (item) {
      this.$store.dispatch('changeIssueToUserReference', {
        issue: this.issue,
        user: this.$store.getters.get({
          type: 'users',
          id: item.value
        })
      })
    }
  },
  components: {
    BasicSelect
  }
}
</script>

<style lang='sass' scoped>
label
  margin-top: 8px
  margin-left: 18px
  margin-bottom: 0
  color: grey
.divider
  margin-top: 0
  margin-bottom: 0
</style>

<style lang='sass'>
.dropdown
  background-color: #f8f8f8 !important
  border: none !important
  color: grey !important
</style>
