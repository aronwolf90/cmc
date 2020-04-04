<template lang='pug'>
  li(v-bind:class="{ active: isActive }")
    a(:href="path", @click.prevent="visit")
      slot
</template>

<script>

export default {
  props: ['path', 'notShowActive'],
  computed: {
    isActive () {
      return !this.notShowActive && this.$route.path == this.path
    }
  },
  methods: {
    visit () {
      Turbolinks.visit(this.path)
    }
  }
}
</script>
