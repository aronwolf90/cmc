<template lang='pug'>
  details-date-time(@submit="submit")
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import detailsDateTime from 'components/details-date-time'

export default {
  components: {
    detailsDateTime
  },
  data () {
    return {
      attributes: {
        'due-at': null
      }
    }
  },
  created () {
    this.$store.dispatch('initIssue', this.issueId).then(response => {
      this.attributes['due-at'] = Utils.attribute(response.data.data, 'due-at')
    })
  },
  computed: {
    issue () {
      return this.$store.getters.issue
    }
  },
  methods: {
    submit (event) {
      event.preventDefault()
      this.$store.dispatch('updateIssue', {
         entry: this.issue,
         attributes: this.attributes
      })
    }
  }
}
</script>
