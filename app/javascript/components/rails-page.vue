<template lang='pug'>
  div(v-html="html")
</template>

<script>

export default {
  data () {
    return {
      html: '<span></span>'
    }
  },
  created () {
    setTimeout(() => {
      // eslint-disable-next-line no-undef
      jqueryFuncs()
    }, 100)
  },
  beforeRouteEnter (to, from, next) {
    window.store.getters.axios.get(
      to.fullPath,
      { headers: { LAYOUT: false } }
    ).then(response => {
      next(vm => {
        vm.html = response.data
      })
    })
  }
}
</script>
