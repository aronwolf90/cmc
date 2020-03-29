<template lang='pug'>
  li.list-group-item
    a.text-dark(:href="`/administration/${resource}/${entryId}`")
      | {{ text || '---' }}
    a.btn.btn-secondary.btn-sm.pull-right(
      v-if="editBtn",
      :href="`/administration/${resource}/${entryId}/edit`"
    )
      .fa.fa-edit
</template>

<script>
import BtnEdit from './btn-edit'

export default {
  props: [
    'entry-type',
    'entry-id',
    'text',
    'resource',
    'editBtn'
  ],
  components: {
    BtnEdit
  }
}
</script>
