<template lang='pug'>
  span.projects-left-aside
    left-aside-item-rails(path="/administration/projects", notShowActive="true")
      i.fa.fa-tasks.fa-lg
        | &nbsp; &nbsp; Project
    left-aside-item-rails(:path="`/administration/projects/${id}`")
      | Dashboard
    left-aside-item-rails(:path="`/administration/projects/${id}/records`")
      | Records
    left-aside-item-rails(:path="`/administration/projects/${id}/documents`")
      | Documents
</template>

<script>
import LeftAsideItem from 'components/left-aside-item'
import LeftAsideItemRails from 'components/left-aside-item-rails'
import { Utils } from 'vuex-jsonapi-client'

export default {
  props: ['id'],
  components: {
    LeftAsideItem,
    LeftAsideItemRails
  }
}
</script>
