<template lang='pug'>
.item 
  a(:href="link") {{ text }}
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
 
export default {
  props: [
    'link',
    'text'
  ]
}
</script>

<style lang='sass' scoped>
a
  color: black
</style>
