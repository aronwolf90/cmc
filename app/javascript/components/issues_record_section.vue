<template lang="pug">
  .issues_record_section
    .clock(v-if="record", @click="clickStop")
      .fa.fa-stop
    .play_btn(v-else, @click="clickPlay")
      .fa.fa-play
</template>

<script>


export default {
  props: ["issue_id", "board_list_id"],
  data() {
    return { time: "00:00:00" }
  },
  mounted() {
    setInterval(() => {
      this.time = this.consumedTime()
    }, 1000)

    this.$store.dispatch("initCurrentUser")
    this.$store.dispatch("initCurrentRecord")
  },
  computed: {
    issue() {
      return this.$store.getters.get({type: "issues", id: this.issue_id})
    },
    currentUser() {
      return this.$store.getters.currentUser
    },
    record() {
      let global_record = this.$store.getters.currentRecord
      if (global_record && global_record.relationships.issue.data.id == this.issue.id) {
        return global_record
      }
    }
  },
  methods: {
    clickPlay() {
      this.$store.dispatch("createRecord", {
        attributes: { "start-time": (new Date()).toString() },
        user: this.currentUser,
        issue: this.issue
      })
    },
    clickStop() {
      this.$store.dispatch("updateRecord", {
        entry: this.record,
        payload: { attributes: { "end-time": (new Date()).toString() }}
      })
    },
    consumedTime() {
      if (!this.record) return "00:00:00"

      let start_time = (new Date(this.record.attributes["start-time"])).getTime()
      let current_time = (new Date).getTime()
      let interval = (current_time - start_time)/1000

      let hours = Math.floor(interval/3600).toString()
      let minutes = Math.floor(interval/60-hours*60).toString()
      let seconds = Math.floor(interval-minutes*60-hours*120).toString()
      return `${hours.padStart(2, "0")}:${minutes.padStart(2, "0")}:${seconds.padStart(2, "0")}`
    }
  }
}

</script>

<style lang="sass" scoped>
  .issue
    margin: 5px
    box-shadow: 0 1px 2px rgba(186,186,186,0.5)
    .issue-body
      padding: 0.5rem
      .text
        overflow: hidden
        text-overflow: ellipsis
        a
          color: black
</style>
