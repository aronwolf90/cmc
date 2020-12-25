<template lang='pug'>
  .records-index
    .align-items-center
      .pull-right.btn-group
        b-button(variant="success", to="/administration/records/new") New record
        b-button(variant="success", href="/administration/records.csv")
          i.fa.fa-file-excel-o
      | {{ thisMonthSpendedTime }} hours has been spent this month
    br
    .table-responsive
      table.table
        tbody
          template(v-for="recordDay in recordDays")
            tr(:key="`record-day-${recordDay.id}`")
              td(colspan=3)
                .font-weight-bold {{ recordDay.attributes.day }}
              td
                .pull-right {{ recordDay.attributes['spent-time'] }}
            tr(
              v-for="record in $store.getters.relationship(recordDay, 'records')",
              :key="`record-${record.id}`"
            )
              td {{ record.attributes.description }}
              td {{ `${record.attributes['start-time']}`.slice(-18).slice(0, 5) }}
              td {{ `${record.attributes['end-time']}`.slice(-18).slice(0, 5) }}
              td
                b-button.pull-right(
                  variant="secondary",
                  size="sm",
                  :to="`/administration/records/${record.id}/edit`"
                )
                  i.fa.fa-edit
    b-pagination-nav(
      :link-gen="linkGen",
      :number-of-pages="paginationPageCount",
      :value="paginationCurrentPage",
      use-router="",
      @page-click.prevent=""
    )
</template>

<script>
export default {
  async beforeRouteEnter (to, from, next) {
    await window.store.dispatch('recordsIndex/fetch')
    next()
  },
  async beforeRouteUpdate (to, from, next) {
    await window.store.dispatch('recordsIndex/fetch', to.query.page)
    next()
  },
  computed: {
    recordDays () {
      return this.$store.getters['recordsIndex/recordDays']
    },
    thisMonthSpendedTime () {
      const seconds = this.$store.getters['recordsIndex/monthSpentTime']
      return [seconds / 3600, seconds / 60 % 60, seconds % 60].map(floatTime => {
        let time = Math.floor(floatTime)
        if (time < 60) {
          return `00${time}`.slice(-2)
        } else {
          return time
        }
      }).join(':')
    },
    paginationPageCount () {
      return this.$store.getters['recordsIndex/paginationPageCount']
    },
    paginationCurrentPage () {
      return this.$store.getters['recordsIndex/paginationCurrentPage']
    },
    fetchingPage () {
      return this.$store.getters['recordsIndex/fetchingPage']
    }
  },
  methods: {
    linkGen (page) {
      return page === 1 ? '?' : `?page=${page}`
    }
  }
}
</script>
