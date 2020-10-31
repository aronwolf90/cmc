<template lang='pug'>
  b-button(
    variant="outline-danger",
    size="sm",
    v-if="canDestroy",
    @click="$emit('destroy')"
  )
    i.fa.fa-trash
</template>

<script>

export default {
  props: [
    'basePath',
    'entryId',
    'entryType'
  ],
  computed: {
    link () {
      return `${this.basePath}/${this.entry.id}/edit`
    },
    entry () {
      return this.$store.getters.entry({
        type: this.entryType,
        id: this.entryId
      })
    },
    canDestroy () {
      return this.entry &&
             this.entry.meta &&
             this.entry.meta.permissions &&
             this.entry.meta.permissions.destroy
    }
  }
}
</script>
