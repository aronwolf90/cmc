<template lang='pug'>
  b-modal(:title="day", ref="modal", @ok="onSubmit", visible=true)
    template(slot="modal-title")
      
    b-form(@submit="onSubmit")
      b-form-group(
        label="Description"
        label-for="input-1"
      )
        b-form-input(
          v-model="form.description"
          type="text"
          placeholder="Enter description"
        )
    template(
      slot="modal-footer",
      slot-scope="{ ok, cancel }"
    )
      b-button(
        variant="danger",
        @click="destroy()",
      ) Destroy
      .flex-grow-1
      b-button(
        variant="secondary",
        @click="cancel()"
      ) Cancel
      b-button(
        variant="primary",
        @click="ok()"
      ) OK
</template>

<script>
 
export default {
  props: [
    'day',
    'userId'
  ],
  data () {
    return {
      attendanceEventId: null,
      attendanceEventType: null,
      form: {
        fromDay: this.day,
        description: null
      }
    }
  },
  mounted () {
    this.$store.dispatch('attendanceEventForDay', {
      day: this.day,
      userId: this.userId
    }).then(attendanceEvent => {
      this.attendanceEventId = attendanceEvent.id
      this.attendanceEventType = attendanceEvent.type
      this.form.fromDay = attendanceEvent.attributes['from-day']
      this.form.description = attendanceEvent.attributes['description']
    })
  },
  computed: {
    attendanceEvent () {
      return this.$store.getters.entry({
        type: this.attendanceEventType,
        id: this.attendanceEventId
      })
    }
  },
  methods: {
    onSubmit () {
      let data = {
        attributes: {
          description: this.form.description,
          "from-day": this.form.fromDay
        },
        relationships: {
          user: {
            data: {
              id: this.userId,
              type: 'users'
            }
          }
        }
      }

      if (this.attendanceEvent) {
        this.$store.dispatch('updateAttendanceEvent', { 
          entry: this.attendanceEvent,
          payload: data
        })
      } else {
        this.$store.dispatch('createAttendanceEvent', data)
      }
    },
    show () {
      this.$refs.modal.show()
    },
    destroy () {
      this.$store.dispatch('destroyAttendanceEvent', this.attendanceEvent)
      this.$refs.modal.hide()
    }
  }
}
</script>
