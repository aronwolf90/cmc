<template lang='pug'>
  right-aside-select(
    id='assigen',
    :label='"Assignment"',
    :options='options',
    :item='item',
    @select="onSelect"
  )
</template>

<script>
import Select from './right_aside_select'

export default {
  props: ['issueId'],
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
      return (this.$store.getters.collection('users') || []).map((user) => {
        return {
          value: user.id,
          text: user.attributes.firstname
        }
      })
    },
    issue () {
      return this.$store.getters.entry({
        type: 'issues',
        id: this.issueId
      })
    },
    user () {
      return this.$store.getters.associatedEntry({
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
        user: this.$store.getters.entry({
          type: 'users',
          id: item.value
        })
      })
    }
  },
  components: {
    'right-aside-select': Select
  }
}
</script>
