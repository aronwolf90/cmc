<template lang='pug'>
  div
    label Assignment
    basic-select(:options="options", :selected-option="item", placeholder="select item", @select="onSelect")
    hr.divider
</template>

<script>
  import { BasicSelect } from 'vue-search-select'

  export default {
    props: ['issue_id'],
    data () {
      return {
        searchText: '',
      }
    },
    created() {
      this.$store.dispatch('initUsers')
    },
    computed: {
      options() {
        return this.$store.getters.getAll('users').map((user) => {
          return {
            value: user.id,
            text: user.attributes.firstname
          }
        })
      },
      item: {
        get() {
          let issue = this.$store.getters.get({type: 'issues', id: this.issue_id})

          let user = this.$store.getters.getAssociatedEntry({entry: issue, name: 'user'})

          if (!user) return

          return { value: user.id, text: user.attributes.firstname }
        },
        set(value) {

        }
      }
    },
    methods: {
      onSelect (item) {
        this.$store.dispatch('changeIssueToUserReference', {
          issue: this.$store.getters.get({type: 'issues', id: this.issue_id}),
          user: this.$store.getters.get({type: 'users', id: item.value}),
          func_success: () => {
            this.item = item
          }
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
