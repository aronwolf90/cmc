<template lang='pug'>
  li.list-group-item
    a.text-dark(:href="`${basePath}/${entryId}`")
      | {{ text || '---' }}
</template>

<script>
import BtnEdit from './btn-edit'

export default {
  props: [
    'entry-type',
    'entry-id',
    'text',
    'base-path'
  ],
  components: {
    BtnEdit
  }
}
</script>
