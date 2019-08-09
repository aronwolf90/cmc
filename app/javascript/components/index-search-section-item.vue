<template lang='pug'>
.item 
  a(:href="link") {{ text }}
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
 
export default {
  props: [
    'itemType',
    'itemId',
    'basePath',
    'attribute'
  ],
  computed: {
    item () {
      return this.$store.getters.entry({
        id: this.itemId, 
        type: this.itemType
      })
    },
    text () {
      return Utils.attribute(this.item, this.attribute)
    },
    link () {
      return `${this.basePath}/${this.itemId}`
    }
  }
}
</script>

<style lang='sass' scoped>
a
  color: black
</style>
