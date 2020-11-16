<template lang='pug'>
  b-button(
    variant="outline-secondary",
    v-if="isGoogleIntegrated",
    @click="$emit('destroy')"
  )
    i.fa.fa-google.d-md-none(aria-hidden="true")
    .d-none.d-md-block Destroy google integration
  b-button(
    variant="outline-secondary",
    v-else="",
    :href="authorizationUrl"
  )
    i.fa.fa-google.d-md-none(aria-hidden="true")
    .d-none.d-md-block Integrate with google
</template>

<script>

export default {
  props: [
    'isGoogleIntegrated',
    'authorizationUrl'
  ]
}
</script>
