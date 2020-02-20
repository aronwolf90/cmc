<template lang='pug'>
  b-form(@submit="$emit('submit', $event)")
    b-input-group(prepend="Username")
      b-form-input
      b-input-group-append
        b-button(type="submit", variant="outline-success") Button
</template>

<script>

export default {
}
</script>
