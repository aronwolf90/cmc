<template lang='pug'>
#right-aside
  .right-aside(v-bind:class="{ expanded: expanded }")
    .right-aside-container
      slot
    .arrow(@click="toggleExpanded")
      .fa.fa-angle-right.fa-2x(v-if="expanded")
      .fa.fa-angle-left.fa-2x(v-else="expanded")
</template>

<script>

export default {
  data () {
    return {
      expanded: false
    }
  },
  methods: {
    toggleExpanded () {
      this.expanded = !this.expanded
    }
  }
}

</script>

<style lang='sass' scoped>
#right-aside
  min-width: 30px
  .right-aside
    background-color: #f8f8f8
    border-left: 2px solid #e7e7e7
    width: 200px
    height: calc(100vh - 44px)
    .arrow
      position: absolute
      bottom: 25px
      right: 9px
    @media only screen and (max-width: 600px)
      position: fixed
      right: 0
      bootom: 0
      z-index: 999
      &:not(.expanded)
        width: 30px
        .right-aside-container
          display: none
    @media only screen and (min-width: 600px)
      .arrow
        display: none
</style>

