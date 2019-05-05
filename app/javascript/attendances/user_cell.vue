<template lang='pug'>
  td {{ user.attributes.firstname }}
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'

export default {
  props: ['user-id', 'type'],
  computed: {
    user () {
      return this.$store.getters.entry({ 
        id: this.userId,
        type: this.type
      })
    }
  }
}
</script>
