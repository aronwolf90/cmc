<template lang='pug'>
  .issue-extra-information(v-if="issue")
    template(v-for="label in labels")
      b-badge(
        v-bind:style="{ 'background-color': label.attributes.color }"
      ) {{ label.attributes.name }}
      |&nbsp;
</template>

<script>

export default {
  props: ['issueRef'],
  computed: {
    issue () {
      return this.$store.getters.entry(this.issueRef)
    },
    labels () {
      return this.$store.getters.relationship(this.issue, 'labels') || []
    }
  }
}

</script>

<style lang='sass' scoped>
</style>
