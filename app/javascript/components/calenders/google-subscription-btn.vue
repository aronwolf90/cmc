<template lang='pug'>
  b-button(variant="outline-secondary", v-if="isGoogleIntegrated")
    i.fa.fa-google.d-md-none(aria-hidden="true")
    .d-none.d-md-block Is integrated with google calender
  b-button(
    variant="outline-secondary",
    v-else="",
    :href="authorizationUrl"
  )
    i.fa.fa-google.d-md-none(aria-hidden="true")
    .d-none.d-md-block Integrate with google calender
</template>

<script>

export default {
  props: [
    'isGoogleIntegrated',
    'authorizationUrl'
  ]
}
</script>
