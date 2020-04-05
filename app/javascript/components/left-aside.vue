<template lang='pug'>
  span.projects-left-aside
    left-aside-item(path="/administration")
      | Dashboard
    left-aside-item(path="/administration/records")
      | Records
    left-aside-item(path="/administration/calender")
      | Calender
    left-aside-item(path="/administration/attendances")
      | Attendances
    left-aside-item(path="/administration/board_lists")
      | Issues
</template>

<script>
import LeftAsideItem from 'components/left-aside-item'

export default {
  components: {
    LeftAsideItem,
  }
}
</script>
