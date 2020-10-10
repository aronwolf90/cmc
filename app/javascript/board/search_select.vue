<template lang='pug'>
  .search
    b-form-input(
      type='text',
      v-model='searchText',
      placeholder='Search',
      size='sm',
      @focus.native="focused = true"
    )
    .items(v-if="issues.length && focused")
      search-select-item(
        v-for="issue in issues",
        :issue-ref="issue",
        :key="issue.id"
      )
</template>

<script>
import SearchSelectItem from 'components/ticket-board/search-select-item'

export default {
  data () {
    return {
      searchText: '',
      focused: false,
      requestIssues: null
    }
  },
  mounted () {
    window.onclick = () => {
      this.focused = false
    }
    this.$el.onclick = (event) => {
      event.stopPropagation()
    }
  },
  components: {
    SearchSelectItem
  },
  computed: {
    issues () {
      return this.relevantIssues || []
    },
    relevantIssues () {
      return this.requestIssues || this.$store.getters.metaCollection('issues')
    }
  },
  methods: {
    request () {
      this.$store.dispatch('request', {
        url: `/api/v1/issues?query=${this.searchText}`
      }).then(response => {
        this.requestIssues = response.data
      })
    }
  },
  watch: {
    searchText () {
      this.request()
    }
  }
}
</script>

<style lang='sass' scoped>
.search
  position: relative
  .items
    position: absolute
    z-index: 1000
    background: white
    width: 460px
    border: 1px solid lightgrey
    margin-left: 1px
    max-height: 400px
    overflow-y: auto
    box-shadow: 0 1px 7px 0 rgba(0, 0, 0, .3)
    padding: 4px
    a
      color: black
</style>
