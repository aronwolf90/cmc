<template lang="pug">
  .issues_record_section
    .clock(v-if="currentRecord")
      | {{ time }}
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
      if (!this.currentRecord) return

      let start_time = (new Date(this.currentRecord.attributes["start_time"])).getTime()
      let current_time = (new Date).getTime()
      let interval = (current_time - start_time)/1000

      let hours = Math.floor(interval/3600).toString()
      let minutes = Math.floor(interval/60-hours*60).toString()
      let seconds = Math.floor(interval-minutes*60-hours*120).toString()
      console.log("hours:" + "hours".padStart(2, "0"))
      self.time = `${hours.padStart(2, "0")}:${minutes.padStart(2, "0")}:${minutes.padStart(2, "0")}`
      console.log(self.time)
    }, 1000)
  },
  computed: {
    issue() {
      return this.$store.getters.get({type: "issues", id: this.issue_id})
    },
    getGlobalConfig() {
      return this.$store.getters.getGlobalConfig()
    },
    currentRecord() {
      return this.$store.getters.getAssociatedEntry({entry: this.getGlobalConfig, name: "current-record"})
    }
  },
  methods: {
    clickPlay() {
      this.$store.dispatch("createRecord", {
        attributes: { "start-time": (new Date()).toString() },
        user: this.currentUser,
        issue: this.issue
      })
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
